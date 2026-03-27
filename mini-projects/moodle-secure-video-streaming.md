
---

```md
# 📹 LMS Secure Video Delivery System (Moodle + Backblaze B2)

## 🚀 Project Overview
This project implements a **secure and scalable video delivery system** for a Learning Management System (Moodle) using **Backblaze B2 cloud storage** and a custom **PHP middleware**.

The goal is to deliver video content securely without exposing direct storage URLs, ensuring **controlled access and improved performance**.

---

## 🏗️ Architecture

User → Moodle LMS → PHP Middleware → Backblaze B2 → Video Streaming

---

## 🔥 Key Features

- 🔒 Private bucket storage (no public access)
- ⏳ Time-limited **signed URLs (token-based authentication)**
- 🚫 Prevents direct video link sharing
- ⚡ Scalable architecture (separates compute & storage)
- 🎯 Secure video streaming inside Moodle
- 📉 Reduced load on hosting server

---

## 🛠️ Tech Stack

- Backblaze B2 (S3-compatible cloud storage)
- PHP (Middleware for secure access)
- Moodle LMS
- HTML5 Video Player
- REST API Integration

---

## ⚙️ How It Works

1. Video is uploaded to a **private Backblaze B2 bucket**
2. User requests video from Moodle LMS
3. Request is sent to **PHP middleware (`get-video.php`)**
4. Middleware generates a **temporary signed URL**
5. Video is streamed securely using that URL

---

## 📂 Project Structure

```

lms-secure-video-delivery/
│
├── backend/
│   └── get-video.php
├── docs/
│   └── setup-guide.md
├── architecture/
│   └── architecture-diagram.png
└── README.md

````

---

## 📹 Video Integration (Moodle)

Example HTML code used in Moodle:

```html
<video controls controlsList="nodownload" width="100%">
  <source 
    src="https://yourdomain.com/get-video.php?video=sample-video.mp4"
    type="video/mp4">
</video>
````

---

## 🔐 Security Implementation

* Videos stored in **private bucket**
* Access only through **middleware**
* Signed URLs are:

  * Time-limited
  * Token-based
* Prevents unauthorized downloads and sharing

---

## ⚡ Benefits

* Cost-effective cloud storage solution
* Improved content security
* Scalable for large number of users
* Reduced load on application server

---

## 🚀 Future Enhancements

* Add CI/CD pipeline for automated deployment
* Implement logging and monitoring
* Integrate CDN for faster global delivery
* Add role-based access control (RBAC)

---

## 👨‍💻 Author

DevOps Engineer Intern
Cloud & DevOps Enthusiast

---

## ⭐ Conclusion

This project demonstrates real-world implementation of:

* Cloud storage integration
* Secure content delivery
* Middleware-based architecture
* DevOps thinking for scalability and security

```

---

```
