require('dotenv').config();
const express = require('express');
const nodemailer = require('nodemailer');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = process.env.PORT || 3000;

const corsOptions = {
    origin: process.env.ALLOWED_ORIGIN || 'https://ahmadraza.in',
    methods: 'GET,POST,OPTIONS',
    allowedHeaders: 'Content-Type,Authorization'
};
app.use(cors(corsOptions));
app.use(bodyParser.json());

app.post('/send-email', async (req, res) => {
    const { name, email, phone, query } = req.body;

    if (!name || !email || !phone || !query) {
        return res.status(400).json({ success: false, message: 'All fields are required' });
    }

    // Setup Transporter for Different SMTP Services
    let transporter = nodemailer.createTransport({
        host: process.env.SMTP_HOST,
        port: process.env.SMTP_PORT || 587,
        secure: process.env.SMTP_PORT == 465, // Use SSL for port 465
        auth: {
            user: process.env.SMTP_USER,
            pass: process.env.SMTP_PASS
        },
        tls: {
            rejectUnauthorized: false // Avoid TLS issues
        }
    });

    let mailOptions = {
        from: process.env.MAIL_FROM,  // Must be verified if using SES
        to: process.env.MAIL_TO,
        subject: process.env.MAIL_SUBJECT || 'New Contact Form Submission',
        text: `Name: ${name}\nEmail: ${email}\nPhone: ${phone}\nQuery: ${query}`
    };

    try {
        let info = await transporter.sendMail(mailOptions);
        console.log(`Email sent: ${info.messageId}`);
        res.status(200).json({ success: true, message: 'Email sent successfully' });
    } catch (error) {
        console.error("Email send error:", error);
        res.status(500).json({
            success: false,
            message: 'Failed to send email. Please try again later.',
            error: error.message
        });
    }
});

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
