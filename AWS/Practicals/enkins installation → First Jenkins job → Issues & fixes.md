---

# 🚀 Jenkins Setup on AWS EC2 (Step-by-Step Guide)

This project demonstrates a complete setup of **Jenkins on AWS EC2**, including:

* EC2 instance creation
* Jenkins installation
* First job execution
* Common issues & fixes

---

## 📌 1. Launch EC2 Instance

Login to AWS Console →
Go to:

```
EC2 → Instances → Launch Instance
```

### ⚙️ Instance Configuration

| Setting       | Value                           |
| ------------- | ------------------------------- |
| Name          | Jenkins-Server                  |
| AMI           | Amazon Linux 2023               |
| Instance Type | t2.micro / t2.small / t3.medium |
| Key Pair      | Create new `.pem` file          |
| Storage       | 20 GB                           |

---

### 🌐 Network Settings (Security Group)

| Type       | Port | Source   | Purpose        |
| ---------- | ---- | -------- | -------------- |
| SSH        | 22   | My IP    | Server access  |
| Custom TCP | 8080 | Anywhere | Jenkins Web UI |

---

## 🔗 2. Connect to EC2

```
EC2 → Instances → Jenkins-Server → Connect
```

Login user:

```
ec2-user
```

---

## 🔄 3. Update Server

```bash
sudo dnf update -y
```

---

## ☕ 4. Install Java (Required for Jenkins)

```bash
sudo dnf install java-17-amazon-corretto -y
```

Verify:

```bash
java -version
```

---

## ⚙️ 5. Install Jenkins

```bash
# Add Jenkins repo
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import key
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
sudo dnf install jenkins -y
```

---

## ▶️ 6. Start Jenkins Service

```bash
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
```

Expected:

```
Active: active (running)
```

---

## 🌍 7. Access Jenkins Web UI

```
http://<EC2-PUBLIC-IP>:8080
```

Example:

```
http://44.xxx.xxx.xxx:8080
```

---

## 🔐 8. Get Admin Password

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Paste this password into Jenkins UI.

---

## 🔌 9. Install Plugins

* Select **Install Suggested Plugins**
* Wait for installation to complete

---

## 👤 10. Create Admin User

| Field     | Example                                       |
| --------- | --------------------------------------------- |
| Username  | admin                                         |
| Password  | ********                                      |
| Full Name | DevOps Admin                                  |
| Email     | [admin@example.com](mailto:admin@example.com) |

---

## 🧪 11. Create First Jenkins Job

* Click **New Item**
* Name: `First-Jenkins-Job`
* Select **Freestyle Project**
* Click **OK**

---

## ⚙️ 12. Add Build Step

Go to:

```
Build Steps → Add Build Step → Execute Shell
```

Add:

```bash
echo "Hello DevOps"
date
```

Click **Save**

---

## ▶️ 13. Run Jenkins Job

* Click **Build Now**
* Open **Console Output**

### ✅ Expected Output

```
Hello DevOps
Mon Mar ...
Finished: SUCCESS
```

---

# 🛠️ Issues & Fixes

## ❌ Issue 1: Jenkins UI Not Opening

**Error:**

```
This site can't be reached
```

**Cause:** Port 8080 blocked

**Fix:** Add inbound rule for port 8080

---

## ❌ Issue 2: SSH Connection Failed

**Error:**

```
Error establishing SSH connection
```

**Cause:** Port 22 not open

**Fix:** Enable SSH (port 22)

---

## ❌ Issue 3: Permission Denied (publickey)

**Error:**

```
Permission denied (publickey)
```

**Fix (Windows):**

```bash
icacls jenkins-key.pem /inheritance:r
icacls jenkins-key.pem /grant:r %username%:R
```

---

## ❌ Issue 4: Jenkins Job Stuck

**Error:**

```
Waiting for next available executor
```

**Fix:**

```
Jenkins → Nodes → Built-In Node → Bring Online
```

---

## ❌ Issue 5: Disk Space Issue

**Error:**

```
Disk space below threshold
```

**Fix:**

```
Nodes → Built-In Node → Configure
Enable Disk Monitoring
Set: 100MB
```

---

# 🏗️ Final Architecture

```
Developer → Jenkins Job → Execute Shell → Build Output
```

```
AWS EC2 (Linux)
        │
        ▼
   Jenkins Server
        │
        ▼
   Build Execution
```

---

# 🔮 Next Steps (CI/CD Pipeline)

```
Developer → GitHub → Jenkins → Build → Test → Deploy
```

### Future Improvements:

* 🔗 Connect Jenkins with GitHub
* ⚙️ Create Jenkins Pipeline (Jenkinsfile)
* 🐳 Build Docker Images
* 🚀 Automated Deployment

---

# ✅ Conclusion

✔ Jenkins successfully installed on AWS EC2
✔ First job executed
✔ CI server ready

---
