package main

import (
        "fmt"
        "html/template"
        "log"
        "net/http"
        "os/exec"
)

const (
        logFile = "/var/log/breeze/breeze.log" // Path to your Nginx error log
        port    = ":4070"                     // Port to run the server on
)

func showLogsHandler(w http.ResponseWriter, r *http.Request) {
        // Check if the log file exists and is readable
        if _, err := exec.LookPath("tail"); err != nil {
                http.Error(w, "The 'tail' command is not available on this system.", http.StatusInternalServerError)
                return
        }

        cmd := exec.Command("tail", "-n", "100", logFile)
        output, err := cmd.CombinedOutput()
        if err != nil {
                http.Error(w, "Error reading the log file: "+err.Error(), http.StatusInternalServerError)
                return
        }

        tmpl := `<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Breeze Logs</title>
</head>
<body>
<pre>{{.}}</pre>
</body>
</html>`

        t, err := template.New("logs").Parse(tmpl)
        if err != nil {
                http.Error(w, "Error rendering the logs: "+err.Error(), http.StatusInternalServerError)
                return
        }

        w.Header().Set("Content-Type", "text/html")
        if err := t.Execute(w, string(output)); err != nil {
                http.Error(w, "Error displaying the logs: "+err.Error(), http.StatusInternalServerError)
        }
}

func main() {
        http.HandleFunc("/", showLogsHandler)
        fmt.Printf("Server running on http://0.0.0.0%s\n", port)
        if err := http.ListenAndServe(port, nil); err != nil {
                log.Fatalf("Failed to start server: %v", err)
        }
}