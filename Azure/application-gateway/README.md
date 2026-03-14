# Azure Application Gateway Project

---

# Step 1. Create Resource Group

In Azure Portal:

Resource Group: **TEST-RG**
Region: **East US** (or your region)

Everything in the lab is deployed inside this resource group.

---

# Step 2. Create Virtual Network A

Name: **VNet-A**
Address space: **10.0.0.0/16**

Subnet: **subnet-a**
Subnet range: **10.0.0.0/24**

This network will contain **VM1**.

---

# Step 3. Create Virtual Network B

Name: **VNet-B**
Address space: **10.1.0.0/16**

Subnet: **subnet-b**
Subnet range: **10.1.0.0/24**

This network will contain **VM2**.

### Important Rule

Both VNets must have **different address ranges**.

Otherwise **VNet Peering will fail**.

---

# Step 4. Create Virtual Machine 1

VM Name: **VM1**
OS: **Ubuntu**
VNet: **VNet-A**
Subnet: **subnet-a**

Private IP: **10.0.0.4**

Enable inbound ports:

* **SSH (22)**
* **HTTP (80)**

---

# Step 5. Connect to VM1

From your computer:

```bash
ssh username@VM1-Public-IP
```

Example:

```bash
ssh snit@20.80.98.26
```

Now you are inside the Linux VM.

---

# Step 6. Update Ubuntu Packages

Refresh the package list.

```bash
sudo apt update
```

---

# Step 7. Install Apache Web Server

Install Apache:

```bash
sudo apt install apache2 -y
```

Apache is the software that runs websites.

---

# Step 8. Enable Apache Service

Enable Apache so it starts automatically when the VM boots.

```bash
sudo systemctl enable apache2
```

---

# Step 9. Start Apache

Start the Apache service.

```bash
sudo systemctl start apache2
```

---

# Step 10. Verify Apache Running

Check the service status.

```bash
sudo systemctl status apache2
```

Output should show:

```
Active: active (running)
```

This means the web server is working.

---

# Step 11. Go to Website Folder

Apache default web directory:

```bash
cd /var/www/html
```

Check existing files:

```bash
ls
```

Output:

```
index.html
```

This is the default Apache page.

---

# Step 12. Remove Default Page

Delete the default webpage.

```bash
sudo rm index.html
```

`sudo` is required because the folder belongs to **root**.

---

# Step 13. Create New Webpage

Create a new webpage file.

```bash
sudo touch index.html
```

---

# Step 14. Edit Webpage

Open the file using **vi editor**.

```bash
sudo vi index.html
```

Write:

```
Welcome to VM1
Server 1 - VNet A
```

Save the file:

```
ESC
:wq
ENTER
```

---

# Step 15. Test Website

Open browser:

```
http://VM1-Public-IP
```

Example:

```
http://20.80.98.26
```

Page should display:

```
Welcome to VM1
Server 1 - VNet A
```

---

# Step 16. Create Virtual Machine 2

VM Name: **VM2**
OS: **Ubuntu**

VNet: **VNet-B**
Subnet: **subnet-b**

Private IP: **10.1.0.4**

---

# Step 17. Install Apache on VM2

SSH into VM2 and run:

```bash
sudo apt update
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2
```

---

# Step 18. Edit VM2 Webpage

Go to web folder:

```bash
cd /var/www/html
```

Edit the webpage:

```bash
sudo vi index.html
```

Write:

```
Welcome to VM2
Server 2 - VNet B
```

Save and exit:

```
ESC
:wq
ENTER
```

---

# Step 19. Create VNet Peering

Go to **VNet-A**

Peer:

```
VNet-A → VNet-B
```

Then from **VNet-B**

Peer:

```
VNet-B → VNet-A
```

Result:

```
VNet-A ↔ VNet-B
```

Now both networks can communicate privately.

---

# Step 20. Create Application Gateway

Name: **TEST-AppGateway**

VNet: **VNet-A**
Subnet: **appgw-subnet**

Frontend:

* Public IP
* Port **80**

Application Gateway acts as a **Layer 7 Load Balancer**.

---

# Step 21. Create HTTP Listener

Protocol: **HTTP**
Port: **80**
Frontend IP: **Public**

The listener waits for incoming web requests.

---

# Step 22. Backend Pool Issue

Initially:

Target Type: **Virtual Machine**

Only **VM1 appeared**.

### Reason

Application Gateway only automatically detects **VMs in the same VNet**.

Your setup:

```
VM1 → VNet-A
VM2 → VNet-B
App Gateway → VNet-A
```

So **VM2 did not appear**.

---

# Backend Settings Explanation

## 1. Cookie-Based Affinity

Keeps a user connected to the **same server**.

Without affinity:

```
User → VM1
Next request → VM2
Next request → VM1
```

With affinity:

```
User → VM1
Next request → VM1
Next request → VM1
```

Used for:

* Login sessions
* Shopping carts

---

## 2. Connection Draining

Allows existing users to **finish their requests** before a server is removed.

Example:

VM1 has **50 users connected**

Gateway behavior:

1. Stops sending new users to VM1
2. Existing users continue
3. New users go to VM2

Users gradually finish:

```
50 → 30 → 10 → 0
```

Then VM1 can safely be removed.

Drain timeout example:

```
1200 seconds (20 minutes)
```

---

## 3. Dedicated Backend Connection

Each user gets a **separate connection** to the backend server.

Disabled:

```
User1 + User2 → shared connection → VM
```

Enabled:

```
User1 → separate connection → VM
User2 → separate connection → VM
```

Used for **special authentication applications**.

---

# Step 23. Add Backend Using IP

Change Target Type:

```
IP Address or FQDN
```

Add:

```
10.0.0.4   VM1
10.1.0.4   VM2
```

Now the backend pool contains **both servers**.

---

# Step 24. Create HTTP Settings

Protocol: **HTTP**

Port: **80**

This defines how the gateway communicates with backend servers.

---

# Step 25. Create Routing Rule

Connect:

```
Listener → Backend Pool
```

Traffic will be sent to:

* VM1
* VM2

---

# Step 26. Allow NSG Rules

Allow inbound traffic:

Port **80**

Source:

```
Application Gateway
```

Otherwise requests will be blocked.

---

# Step 27. Access Application

User opens browser:

```
http://ApplicationGatewayPublicIP
```

Example:

```
http://20.80.98.26
```

---

# Step 28. Final Result

Refreshing the page shows different backend servers.

First request:

```
Welcome to VM1
Server 1 - VNet A
```

Refresh again:

```
Welcome to VM2
Server 2 - VNet B
```

Traffic is load balanced between both servers.

---

# Final Architecture

```
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
      ↔
 VNet Peering
```

---

# Author

Suraj Shivaji Kamble
Azure / DevOps Learning Project
