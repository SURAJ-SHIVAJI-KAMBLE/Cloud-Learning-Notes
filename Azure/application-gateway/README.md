# Azure Application Gateway

## Project Overview
This project demonstrates how to configure **Azure Application Gateway** to distribute incoming traffic between two backend virtual machines located in different virtual networks.

The setup uses **VNet Peering** to allow communication between the Application Gateway and backend servers.

---

## Architecture

User Browser  
↓  
Internet  
↓  
Azure Application Gateway  
↓  
Backend Pool  
├── VM1 (VNet-A)  
└── VM2 (VNet-B)  

VNet-A and VNet-B are connected using **VNet Peering**.

---

## Components Used

- Azure Application Gateway
- Virtual Machine 1 (Backend Server)
- Virtual Machine 2 (Backend Server)
- Virtual Network A (VNet-A)
- Virtual Network B (VNet-B)
- VNet Peering
- Backend Pool
- HTTP Listener
- Health Probe

---

## Architecture Diagram

![Application Gateway Architecture](architecture.png)

---

## Step-by-Step Implementation

### Step 1: Create Resource Group
Create a new resource group in Azure Portal to organize all resources used in this project.

---

### Step 2: Create Virtual Network A
Create **VNet-A** with a subnet for:
- Backend Virtual Machine 1

---

### Step 3: Create Virtual Network B
Create **VNet-B** with a subnet for:
- Backend Virtual Machine 2

---

### Step 4: Configure VNet Peering
Peer **VNet-A** and **VNet-B** so resources in both networks can communicate.

---

### Step 5: Deploy Virtual Machines
Create two virtual machines:

**VM1**
- Located in VNet-A
- Install IIS / Apache web server

**VM2**
- Located in VNet-B
- Install IIS / Apache web server

Each VM hosts a simple webpage identifying the server.

Example:

VM1 webpage:

Welcome to VM1
Server 1 - VNet A


VM2 webpage:

Welcome to VM2
Server 2 - VNet B


---

### Step 6: Create Application Gateway

Create a new **Application Gateway** with:

- Frontend public IP
- Application Gateway subnet
- Backend pool
- HTTP listener

---

### Step 7: Configure Backend Pool

Add both virtual machines:

- VM1 (VNet-A)
- VM2 (VNet-B)

---

### Step 8: Configure HTTP Settings

Set backend HTTP settings including:

- Port 80
- Protocol HTTP

---

### Step 9: Configure Health Probe

Create health probes to monitor backend server availability.

---

### Step 10: Create Routing Rule

Create a rule that connects:

Frontend Listener → Backend Pool

---

### Step 11: Test Application Gateway

Open the **Application Gateway Public IP** in a browser.

Refresh the page multiple times.

You should see responses from both backend servers.

Example:

Welcome to VM1
Server 1 - VNet A


Refresh again:


Welcome to VM2
Server 2 - VNet B


This confirms that **traffic is being load balanced** between the servers.

---

## Final Result

The Azure Application Gateway successfully distributes traffic between backend servers located in different virtual networks using **VNet Peering**.

---

## Author

Suraj Shivaji Kamble  
Cloud Learning Project
