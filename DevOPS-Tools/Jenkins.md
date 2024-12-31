# Jenkins Installation and Setup

## What is Jenkins?

Jenkins is an open-source automation server that enables developers to automate parts of the software development process, such as building, testing, and deploying applications.

## Prerequisites

- A machine with **Java** installed (for standalone installation).
- **Docker** installed (for Docker Compose installation).
- **Docker Compose** installed (for Docker Compose installation).

---

## Option 1: Standalone Installation of Jenkins

### Step 1: Install Java

Jenkins requires Java to run. You can install OpenJDK using the following commands:

### On Ubuntu

```bash
sudo apt update
sudo apt install openjdk-11-jdk
```

### Step 2: Add Jenkins Repository

1. Import the GPG key:

   ```bash
   wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
   ```

2. Add the Jenkins repository:

   ```bash
   sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
   ```

### Step 3: Install Jenkins

```bash
sudo apt update
sudo apt install jenkins
```

### Step 4: Start Jenkins

```bash
sudo systemctl start jenkins
```

### Step 5: Enable Jenkins to Start at Boot

```bash
sudo systemctl enable jenkins
```

### Step 6: Access Jenkins

Open your web browser and navigate to `http://localhost:8080`. You will be prompted to unlock Jenkins with a password.

### Step 7: Get the Unlock Key

Run the following command to retrieve the initial admin password:

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Enter the password to unlock Jenkins and follow the setup wizard.

---

## Option 2: Docker Compose-Based Installation of Jenkins

### Step 1: Create a Docker Compose File

Create a directory for Jenkins and navigate to it:

```bash
mkdir jenkins-docker
cd jenkins-docker
```

Create a `docker-compose.yml` file with the following content:

```yaml
version: '3.8'
services:
  jenkins:
    image: jenkins/jenkins:lts  # 🐳 Use the latest Jenkins LTS image
    privileged: true  # 🔒 Allow the container to run in privileged mode
    user: root  # 👤 Run Jenkins as the root user
    ports:
      - 8080:8080  # 🌐 Map Jenkins web interface port to the host
      - 50000:50000  # 🌐 Map Jenkins agent port to the host
    container_name: jenkins  # 📛 Name the container "jenkins"
    volumes:
      - ./jenkins_home:/var/jenkins_home  # 💾 Mount host directory to Jenkins home directory
      - /var/run/docker.sock:/var/run/docker.sock  # 🔌 Allow Jenkins to use Docker commands
      - ./jenkins-backup:/var/jenkins-backup  # 💾 Mount host directory for Jenkins backups
    restart: always  # 🔄 Set the restart policy to always restart on failure
```

### Step 2: Start Jenkins

Run the following command to start Jenkins using Docker Compose:

```bash
docker-compose up -d
```

### Step 3: Access Jenkins

Open your web browser and navigate to `http://localhost:8080`. You will be prompted to unlock Jenkins with a password.

### Step 4: Get the Unlock Key

Run the following command to retrieve the initial admin password:

```bash
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

Enter the password to unlock Jenkins and follow the setup wizard.

---

## Conclusion

Jenkins can be easily set up using either a standalone installation or via Docker Compose. After installation, access the Jenkins web interface and complete the setup process. You can then start creating and managing your CI/CD pipelines.

> For more advanced configurations and plugins, refer to the official [Jenkins documentation](https://www.jenkins.io/doc/).