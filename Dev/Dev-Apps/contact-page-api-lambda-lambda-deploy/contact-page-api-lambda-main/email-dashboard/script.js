document.getElementById("emailForm").addEventListener("submit", async function(event) {
    event.preventDefault();

    // Get form values
    const name = document.getElementById("name").value;
    const email = document.getElementById("email").value;
    const phone = document.getElementById("phone").value;
    const query = document.getElementById("query").value;
    const responseMessage = document.getElementById("responseMessage");

    // API URL (Update this if deployed on AWS Lambda or other server)
    const API_URL = "http://localhost:3000/send-email";

    // Fetch Request to Send Email
    try {
        let response = await fetch(API_URL, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ name, email, phone, query })
        });

        let data = await response.json();
        if (data.success) {
            responseMessage.style.color = "#28a745";
            responseMessage.textContent = "✅ Email Sent Successfully!";
        } else {
            responseMessage.style.color = "#ff0000";
            responseMessage.textContent = "❌ Failed to Send Email!";
        }
    } catch (error) {
        responseMessage.style.color = "#ff0000";
        responseMessage.textContent = "❌ Error Sending Email!";
    }
});
