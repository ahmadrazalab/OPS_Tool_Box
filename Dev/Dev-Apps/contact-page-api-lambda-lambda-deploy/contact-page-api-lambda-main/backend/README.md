Here's a **README.md** file for your **Email API** that can be deployed on **AWS Lambda** or any **server (EC2, VPS, Docker, etc.)**. 🚀  

---

## **📧 Email API - Universal SMTP Mailer**
A simple **Node.js Express API** for sending emails via **AWS SES, Gmail, Resend, Mailgun, SendGrid, or any SMTP provider**.  

It supports **deployment on AWS Lambda** (serverless) or **any Node.js environment (EC2, VPS, Docker, etc.)**.

---

## **🚀 Features**
✅ Works with **any SMTP provider**  
✅ Supports **AWS SES, Gmail, Resend, Mailgun, SendGrid, etc.**  
✅ Deployable on **AWS Lambda (Serverless) or any server**  
✅ Uses **environment variables** for security  
✅ CORS support for frontend integration  
✅ **Fast & Lightweight** (Express.js & Nodemailer)  

---

## **📌 Deployment Options**
- **🖥️ Run on any server** (EC2, VPS, Bare Metal)
- **🛠️ Deploy on AWS Lambda** (Serverless)
- **🐳 Docker Container Deployment**

---

## **⚡️ Installation & Setup**
### **1️⃣ Clone the Repository**
```sh
git clone https://github.com/yourusername/email-api.git
cd email-api
```

### **2️⃣ Install Dependencies**
```sh
npm install
```

### **3️⃣ Configure Environment Variables**
Create a `.env` file in the root directory and configure your SMTP settings.

```ini
PORT=3000
ALLOWED_ORIGIN=https://yourfrontend.com

SMTP_HOST=email-smtp.us-east-1.amazonaws.com  # Example: AWS SES SMTP
SMTP_PORT=587
SMTP_USER=YOUR_SMTP_USERNAME
SMTP_PASS=YOUR_SMTP_PASSWORD

MAIL_FROM=your-email@example.com
MAIL_TO=recipient@example.com
MAIL_SUBJECT=New Contact Form Submission
```

---

## **🛠 Running Locally**
```sh
node server.js
```
- API runs on **http://localhost:3000**
- **Test API using Postman or cURL**

---

## **📨 API Usage**
### **POST /send-email**
Send an email using the configured SMTP provider.

#### **📌 Request Body (JSON)**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "phone": "1234567890",
  "query": "I need support regarding my account."
}
```

#### **✅ cURL Example**
```sh
curl -X POST http://localhost:3000/send-email \
     -H "Content-Type: application/json" \
     -d '{
           "name": "John Doe",
           "email": "john@example.com",
           "phone": "1234567890",
           "query": "I need support regarding my account."
         }'
```

#### **✅ Postman Collection**
1. Open **Postman**.
2. Click **Import** → Upload this JSON:
```json
{
  "info": {
    "name": "Email API",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "item": [
    {
      "name": "Send Email",
      "request": {
        "method": "POST",
        "header": [
          {
            "key": "Content-Type",
            "value": "application/json"
          }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\n  \"name\": \"John Doe\",\n  \"email\": \"john@example.com\",\n  \"phone\": \"1234567890\",\n  \"query\": \"I need support regarding my account.\"\n}"
        },
        "url": {
          "raw": "http://localhost:3000/send-email",
          "protocol": "http",
          "host": ["localhost"],
          "port": "3000",
          "path": ["send-email"]
        }
      }
    }
  ]
}
```
---

## **🚀 Deploy to AWS Lambda**
### **1️⃣ Install AWS CLI & Serverless Framework**
```sh
npm install -g serverless
aws configure
```
### **2️⃣ Deploy with Serverless**
Modify `serverless.yml`:
```yaml
service: email-api
provider:
  name: aws
  runtime: nodejs18.x
  environment:
    SMTP_HOST: email-smtp.us-east-1.amazonaws.com
    SMTP_PORT: 587
    SMTP_USER: YOUR_SMTP_USERNAME
    SMTP_PASS: YOUR_SMTP_PASSWORD
    MAIL_FROM: your-email@example.com
    MAIL_TO: recipient@example.com
    MAIL_SUBJECT: "New Contact Form Submission"
functions:
  sendEmail:
    handler: server.handler
    events:
      - http:
          path: send-email
          method: post
```
**Deploy with:**
```sh
serverless deploy
```
- API will be available at:  
  **`https://your-lambda-url.amazonaws.com/dev/send-email`**

---

## **🐳 Docker Deployment**
Create a `Dockerfile`:
```dockerfile
FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "server.js"]
```
Build & Run:
```sh
docker build -t email-api .
docker run -p 3000:3000 --env-file .env email-api
```

---

## **🚨 Troubleshooting**
### **Error: `535 Authentication Credentials Invalid`**
- Ensure **SMTP username/password** are correct.
- **For Gmail**, enable **App Passwords** instead of your normal password.
- **For AWS SES**, ensure credentials are from **SMTP Settings**, not IAM.

### **Error: `Message rejected: Email address not verified`**
- If using **AWS SES in Sandbox**, verify the **MAIL_FROM & MAIL_TO** emails in AWS SES Console.

### **CORS Issues?**
- Add your frontend domain to `.env` → `ALLOWED_ORIGIN=https://yourfrontend.com`

---

## **📜 License**
This project is licensed under the **MIT License**.

---

## **💬 Need Help?**
Feel free to open an issue or reach out! 🚀