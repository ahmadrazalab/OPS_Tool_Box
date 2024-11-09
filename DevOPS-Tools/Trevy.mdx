## Trevy Documentation: Full Setup and Scan Guide

### Introduction to Trevy

Trevy is a lightweight and easy-to-use tool for managing and scanning Docker images for vulnerabilities. It leverages popular vulnerability databases to ensure your container images are secure. This guide provides comprehensive information on installing, setting up, and using Trevy with practical examples.

### Key Features of Trevy

- **Lightweight**: Minimal overhead, easy to install and run.
- **Integration**: Works with Docker and popular CI/CD pipelines.
- **Vulnerability Scanning**: Detects vulnerabilities in Docker images using reliable databases.

### Prerequisites

- A system with Docker installed.
- Basic knowledge of Docker and containerization.

### Installation

#### Installing Trevy on Ubuntu

1. **Update the package list and install prerequisites**:

    ```sh
    sudo apt update
    sudo apt install -y curl
    ```

2. **Download and install Trevy**:

    ```sh
    curl -sSfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin
    ```

3. **Verify the installation**:

    ```sh
    trivy --version
    ```

#### Installing Trevy on macOS

1. **Using Homebrew**:

    ```sh
    brew install aquasecurity/trivy/trivy
    ```

2. **Verify the installation**:

    ```sh
    trivy --version
    ```

### Basic Usage

#### Scanning a Docker Image

Trevy can scan Docker images for vulnerabilities. Below is an example of how to scan an image:

1. **Pull a Docker image**:

    ```sh
    docker pull nginx:latest
    ```

2. **Scan the image with Trevy**:

    ```sh
    trivy image nginx:latest
    ```

    Example output:

    ```sh
    2023-08-02T10:00:00.000Z        INFO    Need to update DB
    2023-08-02T10:00:00.000Z        INFO    Downloading DB...
    2023-08-02T10:00:00.000Z        INFO    Detecting Nginx vulnerabilities...

    nginx:latest (alpine 3.13.2)
    =============================
    Total: 10 (UNKNOWN: 0, LOW: 5, MEDIUM: 3, HIGH: 2, CRITICAL: 0)

    +-------------+------------------+----------+-------------------+---------------+---------------------------------------+
    |  LIBRARY    | VULNERABILITY ID | SEVERITY | INSTALLED VERSION | FIXED VERSION |                 TITLE                |
    +-------------+------------------+----------+-------------------+---------------+---------------------------------------+
    | openssl     | CVE-2021-23840   | HIGH     | 1.1.1i-r0         | 1.1.1j-r0     | openssl: integer overflow in X509    |
    |             |                  |          |                   |               | certificate verification             |
    +-------------+------------------+----------+-------------------+---------------+---------------------------------------+
    ```

#### Scanning a Local Directory

Trevy can also scan local directories for vulnerabilities, which is useful for scanning application dependencies:

1. **Scan a local directory**:

    ```sh
    trivy fs /path/to/your/project
    ```

    Example output:

    ```sh
    2023-08-02T10:10:00.000Z        INFO    Need to update DB
    2023-08-02T10:10:00.000Z        INFO    Downloading DB...
    2023-08-02T10:10:00.000Z        INFO    Detecting file vulnerabilities...

    /path/to/your/project (alpine 3.13.2)
    =====================================
    Total: 5 (UNKNOWN: 0, LOW: 2, MEDIUM: 2, HIGH: 1, CRITICAL: 0)

    +-------------+------------------+----------+-------------------+---------------+---------------------------------------+
    |  LIBRARY    | VULNERABILITY ID | SEVERITY | INSTALLED VERSION | FIXED VERSION |                 TITLE                |
    +-------------+------------------+----------+-------------------+---------------+---------------------------------------+
    | libc6       | CVE-2021-33574   | HIGH     | 2.31-0ubuntu9.9   | 2.31-0ubuntu9.9| glibc: use-after-free in _IO_str_    |
    |             |                  |          |                   |               | overrun in glibc                     |
    +-------------+------------------+----------+-------------------+---------------+---------------------------------------+
    ```

### Advanced Usage

#### Ignoring Specific Vulnerabilities

To ignore specific vulnerabilities, create a `.trivyignore` file in the directory you are scanning:

1. **Create a `.trivyignore` file**:

    ```sh
    echo "CVE-2021-23840" >> /path/to/your/project/.trivyignore
    ```

2. **Scan the directory**:

    ```sh
    trivy fs /path/to/your/project
    ```

    The specified vulnerability will be ignored in the scan results.

#### Scheduling Regular Scans

To schedule regular scans, you can use `cron` jobs. Here’s an example of how to set up a daily scan:

1. **Edit the crontab**:

    ```sh
    crontab -e
    ```

2. **Add the following line to schedule a daily scan at midnight**:

    ```sh
    0 0 * * * /usr/local/bin/trivy image nginx:latest >> /var/log/trivy.log 2>&1
    ```

    This will scan the `nginx:latest` image daily at midnight and log the results to `/var/log/trivy.log`.

### Example CI/CD Pipeline Integration

Trevy can be integrated into CI/CD pipelines to ensure Docker images are scanned for vulnerabilities before deployment.

#### GitHub Actions Example

1. **Create a GitHub Actions workflow file**:

    ```yaml
    name: Docker Image CI

    on:
      push:
        branches:
          - main

    jobs:
      build:
        runs-on: ubuntu-latest

        steps:
          - name: Checkout code
            uses: actions/checkout@v2

          - name: Set up Docker Buildx
            uses: docker/setup-buildx-action@v1

          - name: Login to Docker Hub
            uses: docker/login-action@v1
            with:
              username: ${{ secrets.DOCKER_USERNAME }}
              password: ${{ secrets.DOCKER_PASSWORD }}

          - name: Build Docker image
            run: docker build -t your_username/your_image:latest .

          - name: Install Trivy
            run: |
              curl -sSfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin
              trivy --version

          - name: Scan Docker image
            run: trivy image your_username/your_image:latest
    ```

2. **Commit and push the workflow file**:

    ```sh
    git add .github/workflows/docker-image-ci.yml
    git commit -m "Add Docker image CI workflow"
    git push origin main
    ```

This workflow checks out the code, builds the Docker image, installs Trevy, and scans the image for vulnerabilities. If any vulnerabilities are found, the build will fail, ensuring that only secure images are deployed.


> Trevy is a powerful tool for scanning Docker images and local directories for vulnerabilities. By following this guide, you should be able to install, configure, and use Trevy to ensure your container images are secure. With integration into CI/CD pipelines, you can automate the security checks and maintain a secure deployment process.