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

Did not understand how to add EC2 instances

#### ✅ Solution:

* Select BOTH EC2 instances
* Click **Include as pending below**
* Click **Create target group**

---

### 🔹 Step 4: Create Application Load Balancer (ALB)

Go to:
EC2 → Load Balancers → Create Load Balancer

Select:

* Application Load Balancer
* Internet-facing

Fill:

* Listener: HTTP (80)
* Select your target group

---

### 🔹 Step 5: Create Security Group (During ALB creation)

#### 🔴 Issue:

Initially selected default security group

#### ✅ Fix:

Create new security group with:

* Type: HTTP
* Port: 80
* Source: 0.0.0.0/0

Then attach this security group to ALB

---

### 🔹 Step 6: 504 Gateway Timeout Error

After opening ALB DNS:

```bash
504 Gateway Time-out
```

---

## 🔍 Root Cause

* Target group showed: Unhealthy
* Error: Request timed out
* ALB could not reach EC2 instances

---

## ✅ Step 7: Fix EC2 Security Group (MAIN FIX)

Go to:
EC2 → Instances → Select each instance → Security → Edit inbound rules

Add:

* Type: HTTP
* Port: 80
* Source: 0.0.0.0/0

---

## 🔧 Additional Verification

### Check Apache status:

```bash
sudo systemctl status httpd
```

### Start Apache if needed:

```bash
sudo systemctl start httpd
```

### Test locally:

```bash
curl localhost
```

---

## 🎯 Final Result

After fix:

* Target group → Healthy
* ALB working successfully

Output:

```bash
Hello from Server 1
Hello from Server 2
```

---

## 🧠 Key Learnings

* ALB → Target Group → EC2 flow
* Importance of Security Groups
* Debugging 504 Gateway Timeout
* Health checks concept

---

## 🔥 Interview Answer

"I configured an AWS Application Load Balancer with two EC2 instances. I faced a 504 Gateway Timeout issue due to blocked HTTP traffic in the EC2 security group. I resolved it by allowing port 80, which made the instances healthy and restored load balancing."

---

## 📂 Conclusion

This project helped in understanding:

* Load balancing in AWS
* Networking flow
* Real-world troubleshooting
