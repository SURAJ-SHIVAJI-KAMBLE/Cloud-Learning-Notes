# AWS Application Load Balancer Practical (With Real Issue & Fix)

## 📌 Objective

Deploy an Application Load Balancer (ALB) and distribute traffic across multiple EC2 instances while troubleshooting real-world issues.

---

## 🧱 Architecture

User → ALB → Target Group → EC2 → Apache

---

## 🚀 Step-by-Step Implementation

### 🔹 Step 1: Launch EC2 Instances

* Launch 2 EC2 instances (Amazon Linux)

### Install Apache (run on BOTH instances)

```bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
```

---

### 🔹 Step 2: Configure Web Pages

#### Instance 1:

```bash
echo "Hello from Server 1" | sudo tee /var/www/html/index.html
```

#### Instance 2:

```bash
echo "Hello from Server 2" | sudo tee /var/www/html/index.html
```

---

### 🔹 Step 3: Create Target Group

Go to:
EC2 → Target Groups → Create target group

Fill:

* Target type: Instances
* Protocol: HTTP
* Port: 80

Click **Next**

#### 🔴 Issue Faced:

Confusion while adding EC2 instances

#### ✅ Solution:

* Select BOTH EC2 instances
* Click **Include as pending below**
* Click **Create target group**

---

### 🔹 Step 4: Create Application Load Balancer (ALB)

Go to:
EC2 → Load Balancers → Create Load Balancer → Application Load Balancer

#### Fill Basic Details:

* Name: my-alb
* Scheme: Internet-facing
* IP type: IPv4

---

### 🔹 Network Mapping (IMPORTANT)

* Select your VPC
* Select **at least 2 Availability Zones**

Example:

* ap-south-1a ✅
* ap-south-1b ✅

👉 Subnets will be auto-selected

---

### 🔹 Security Group (IMPORTANT)

#### 🔴 Issue:

Initially selected default security group

#### ✅ Fix:

* Select the security group you created:

  * `my-alb-sg`
* This should allow:

  * HTTP (Port 80)

---

### 🔹 Listener and Routing (VERY IMPORTANT)

* Listener: HTTP (Port 80)

👉 In **Default action dropdown**:

* Select your target group:

  * `my-tg`

---

### 🔹 Final Step

* Scroll down
* Click **Create Load Balancer**

---

### 🔹 Step 5: 504 Gateway Timeout Error

After opening ALB DNS:

```
504 Gateway Time-out
```

---

## 🔍 Root Cause

* Target group status: Unhealthy
* Error: Request timed out
* ALB was not able to reach EC2

---

## ✅ Step 6: Fix EC2 Security Group (MAIN FIX)

Go to:
EC2 → Instances → Select each instance → Security → Edit inbound rules

Add:

* Type: HTTP
* Port: 80
* Source: 0.0.0.0/0

---

## 🔧 Verification Commands

### Check Apache:

```bash
sudo systemctl status httpd
```

### Start Apache:

```bash
sudo systemctl start httpd
```

### Test locally:

```bash
curl localhost
```

---

## 🎯 Final Result

* Target group → Healthy
* ALB working successfully

Output:

```
Hello from Server 1
Hello from Server 2
```

---

## 🧠 Key Learnings

* ALB → Target Group → EC2 flow
* Importance of Security Groups
* Availability Zones concept
* Debugging 504 Gateway Timeout
* Health checks

---

## 🔥 Interview Answer

"I configured an AWS Application Load Balancer with two EC2 instances across multiple availability zones. I faced a 504 Gateway Timeout due to blocked HTTP traffic in EC2 security groups and resolved it by allowing port 80."

---

## 📂 Conclusion

This project helped in understanding:

* Load balancing in AWS
* Networking and security
* Real-world troubleshooting
