---

# 🚀 Azure Application Gateway Practical Lab

### Multi-VNet Load Balancing with VM1 & VM2

---

## 📌 Step 1 – Create Resource Group

Create a Resource Group in Azure Portal:

* **Name:** `TEST-RG`
* **Region:** `East US` (or your region)

👉 All resources in this lab will be deployed inside this Resource Group.

---

## 📌 Step 2 – Create Virtual Network A

* **Name:** `VNet-A`
* **Address Space:** `10.0.0.0/16`

### Subnet:

* **Name:** `subnet-a`
* **Range:** `10.0.0.0/24`

👉 This VNet will host **VM1**

---

## 📌 Step 3 – Create Virtual Network B

* **Name:** `VNet-B`
* **Address Space:** `10.1.0.0/16`

### Subnet:

* **Name:** `subnet-b`
* **Range:** `10.1.0.0/24`

👉 This VNet will host **VM2**

⚠️ **Important Rule:**
VNet address spaces must be different, otherwise **peering will fail**.

---

## 📌 Step 4 – Create Virtual Machine 1

* **VM Name:** `VM1`
* **OS:** Ubuntu
* **VNet:** `VNet-A`
* **Subnet:** `subnet-a`
* **Private IP:** `10.0.0.4`

### Enable Ports:

* SSH → `22`
* HTTP → `80`

---

## 📌 Step 5 – Connect to VM1

```bash
ssh snit@20.80.98.26
```

👉 You are now inside the Linux VM.

---

## 📌 Step 6 – Update Packages

```bash
sudo apt update
```

👉 Refreshes package list.

---

## 📌 Step 7 – Install Apache

```bash
sudo apt install apache2
```

👉 Apache is used to host websites.

---

## 📌 Step 8 – Enable Apache

```bash
sudo systemctl enable apache2
```

---

## 📌 Step 9 – Start Apache

```bash
sudo systemctl start apache2
```

---

## 📌 Step 10 – Verify Apache

```bash
sudo systemctl status apache2
```

✅ Output:

```
Active: active (running)
```

---

## 📌 Step 11 – Navigate to Web Folder

```bash
cd /var/www/html
ls
```

👉 Default file:

```
index.html
```

---

## 📌 Step 12 – Remove Default Page

```bash
sudo rm index.html
```

---

## 📌 Step 13 – Create New Page

```bash
sudo touch index.html
```

---

## 📌 Step 14 – Edit Webpage

```bash
sudo vi index.html
```

### Add content:

```
Welcome to VM1
Server 1 - VNet A
```

Save:

```
ESC → :wq → ENTER
```

---

## 📌 Step 15 – Test Website

Open browser:

```
http://20.80.98.26
```

✅ Output:

```
Welcome to VM1
Server 1 - VNet A
```

---

## 📌 Step 16 – Create Virtual Machine 2

* **VM Name:** `VM2`
* **OS:** Ubuntu
* **VNet:** `VNet-B`
* **Subnet:** `subnet-b`
* **Private IP:** `10.1.0.4`

---

## 📌 Step 17 – Install Apache on VM2

```bash
sudo apt update
sudo apt install apache2
```

---

## 📌 Step 18 – Edit VM2 Webpage

```bash
cd /var/www/html
sudo vi index.html
```

### Add:

```
Welcome to VM 2
Server 2 - VNet B
```

---

## 📌 Step 19 – Create VNet Peering

### From VNet-A:

```
Peer → VNet-A → VNet-B
```

### From VNet-B:

```
Peer → VNet-B → VNet-A
```

✅ Result:

```
VNet-A ↔ VNet-B
```

👉 Both networks can now communicate privately.

---

## 📌 Step 20 – Create Application Gateway

* **Name:** `TEST-AppGateway`
* **VNet:** `VNet-A`
* **Subnet:** `appgw-subnet`
* **Frontend:** Public IP
* **Port:** `80`

👉 Application Gateway = **Layer 7 Load Balancer**

---

## 📌 Step 21 – Create HTTP Listener

* **Protocol:** HTTP
* **Port:** 80
* **Frontend IP:** Public

👉 Listens for incoming traffic.

---

## 📌 Step 22 – Backend Pool Issue (Important Concept)

Initially:

* Target Type → Virtual Machine
* Only **VM1 appeared**

### ❗ Reason:

Application Gateway detects only VMs in **same VNet**

Your setup:

```
VM1 → VNet-A
VM2 → VNet-B
App Gateway → VNet-A
```

👉 So VM2 is not visible

---

## 📌 Step 23 – Add Backend Using IP

Change:

```
Target Type → IP Address or FQDN
```

Add:

```
10.0.0.4 (VM1)
10.1.0.4 (VM2)
```

✅ Now both VMs are part of backend pool

---

## 📌 Step 24 – Create HTTP Settings

* **Protocol:** HTTP
* **Port:** 80

👉 Defines how gateway talks to backend

---

## 📌 Step 25 – Create Routing Rule

```
Listener → Backend Pool
```

👉 Routes traffic to:

* VM1
* VM2

---

## 📌 Step 26 – Configure NSG Rules

Allow:

* **Port:** 80
* **Source:** Application Gateway

👉 Otherwise traffic will be blocked

---

## 📌 Step 27 – Access Application

Open browser:

```
http://<Application-Gateway-Public-IP>
```

---

## 📌 Step 28 – Final Result

On refresh:

```
VM1 → Welcome to VM1
VM2 → Welcome to VM2
```

👉 Traffic alternates between servers (Load Balancing)

---

# ⚙️ Important Concepts (Interview + Real World)

## 🍪 Cookie-Based Affinity

👉 Keeps user connected to same server

### Without Affinity:

```
User → VM1 → VM2 → VM1
```

### With Affinity:

```
User → VM1 → VM1 → VM1
```

📌 Used for:

* Login sessions
* Shopping carts

---

## 🔄 Connection Draining

👉 Allows existing users to finish before removing server

### Example:

* Total users on VM1 = 50

With draining:

```
New users → VM2
Old users → continue on VM1
```

Gradually:

```
50 → 30 → 10 → 0
```

📌 Your Config:

* Enabled
* Timeout: `1200 sec (20 mins)`

---

## 🔌 Dedicated Backend Connection

👉 Each user gets separate connection

### Disabled:

```
Users share connection
```

### Enabled:

```
Each user → separate connection
```

📌 Used for:

* Special authentication apps

---

# 🏗️ Final Architecture

```id="arch1"
User Browser
      ↓
   Internet
      ↓
Application Gateway
      ↓
Backend Pool
   ↙       ↘
 VM1       VM2
VNet-A   VNet-B
     ↔ VNet Peering
```

---

# 🎯 Final Outcome

✅ Multi-VNet architecture
✅ VNet Peering configured
✅ Application Gateway Load Balancing
✅ Real-world production-like setup

---
