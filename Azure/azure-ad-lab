# Azure Active Directory Domain Controller + Client Join (Step-by-Step Lab)

# Overview

This lab demonstrates how to:

* Create Domain Controller in Azure
* Install Active Directory
* Configure DNS
* Create Client VM
* Join Client to Domain

This is **Real Enterprise Setup** used in companies.

---

# Architecture

```
Azure VM 1 → Domain Controller (DC01)
Azure VM 2 → Domain Joined Client (Client01)
```

---

# Prerequisites

* Azure Account
* Basic knowledge of Azure Portal
* Two Windows Server VMs

---

# Step 1 — Create Resource Group

Login to Azure Portal

Search:

```
Resource Groups
```

Click:

```
Create
```

Fill:

```
Resource Group Name: RG-AD-LAB
Region: Central India (or any)
```

Click:

```
Review + Create
Create
```

---

# Step 2 — Create Virtual Network

Search:

```
Virtual Networks
```

Click:

```
Create
```

Fill:

```
Name: company-vnet
Resource Group: RG-AD-LAB
Region: Same as resource group
```

IP Range:

```
10.0.0.0/16
```

Subnet:

```
default
10.0.0.0/24
```

Click:

```
Review + Create
Create
```

---

# Step 3 — Create Domain Controller VM

Search:

```
Virtual Machines
```

Click:

```
Create → Azure Virtual Machine
```

Fill Basic Details:

```
Resource Group: RG-AD-LAB
VM Name: DC01
Region: Same region
Image: Windows Server 2022 / 2025
Size: Standard B1s (lab purpose)
```

Create admin credentials:

```
Username: azureadmin
Password: Strong password
```

Networking:

```
Virtual Network: company-vnet
Subnet: default
Public IP: Yes
```

Click:

```
Review + Create
Create
```

Wait until deployment completes.

---

# Step 4 — Login to DC01

Go to:

```
Virtual Machine → DC01
```

Click:

```
Connect → RDP
Download RDP file
```

Login using:

```
Username: azureadmin
Password: your password
```

---

# Step 5 — Set Static Private IP

Go to Azure Portal:

```
DC01 → Networking
```

Click:

```
Network Interface
```

Click:

```
IP Configuration
```

Change:

```
Private IP → Static
```

Enter:

```
10.0.0.4
```

Click:

```
Save
```

---

# Step 6 — Configure DNS for Domain Controller

Inside DC01 VM:

Go to:

```
Control Panel
```

Open:

```
Network and Internet
```

Click:

```
Network Connections
```

Right Click:

```
Ethernet → Properties
```

Select:

```
Internet Protocol Version 4 (IPv4)
```

Click:

```
Properties
```

Fill:

```
IP Address:        10.0.0.4
Subnet Mask:       255.255.255.0
Default Gateway:   10.0.0.1
Preferred DNS:     10.0.0.4
Alternate DNS:     Leave Blank
```

Click:

```
OK
OK
Close
```

Verify:

Open Command Prompt

Run:

```
ipconfig /all
```

---

# Step 7 — Install Active Directory

Open:

```
Server Manager
```

Click:

```
Add Roles and Features
```

Click:

```
Next
Next
```

Select:

```
Role-based or feature-based installation
```

Next

Select Server:

```
DC01
```

Next

Select:

```
Active Directory Domain Services
```

Click:

```
Add Features
```

Next → Install

Wait for installation

---

# Step 8 — Promote to Domain Controller

After installation click:

```
Promote this server to a domain controller
```

Select:

```
Add a new forest
```

Enter:

```
company.local
```

Click:

```
Next
```

Set DSRM Password:

```
Strong Password
```

Click:

```
Next → Next → Install
```

Server restarts automatically

---

# Step 9 — Verify Domain Controller

After restart login again

Open:

```
Server Manager
```

Click:

```
Tools
```

Verify these options:

```
Active Directory Users and Computers
DNS
Group Policy Management
```

Domain Controller ready.

---

# Step 10 — Create Client VM

Create new Virtual Machine:

```
Name: Client01
OS: Windows Server / Windows 10
Resource Group: RG-AD-LAB
```

Networking:

```
Virtual Network: company-vnet
Subnet: default
```

Create VM

---

# Step 11 — Configure DNS for Client

Login to Client01

Open:

```
Network Settings
```

Go to:

```
IPv4 Properties
```

Fill:

```
IP Address:        10.0.0.5
Subnet Mask:       255.255.255.0
Default Gateway:   10.0.0.1
Preferred DNS:     10.0.0.4
Alternate DNS:     Leave Blank
```

Click OK

Restart Client01

---

# Step 12 — Join Domain

Open:

```
System Settings
```

Click:

```
Advanced System Settings
```

Go to:

```
Computer Name Tab
```

Click:

```
Change
```

Select:

```
Domain
```

Enter:

```
company.local
```

Click OK

Enter credentials:

```
company\administrator
```

Click OK

Restart machine

---

# Step 13 — Verify Domain Join

Login screen:

```
company\administrator
```

OR

```
user@company.local
```

---

# Testing

From Client01:

Open Command Prompt

Run:

```
ping 10.0.0.4
```

Should succeed

---

# Lab Completed

You successfully created:

* Azure Domain Controller
* Active Directory
* DNS Configuration
* Domain Joined Client

---

# Skills Learned

* Azure Virtual Machines
* Active Directory
* DNS
* Domain Controller
* Domain Join
* Enterprise Architecture

---

# Project Name Suggestion

```
Azure-ActiveDirectory-Lab
```

---

# Folder Structure Suggestion

```
Azure-ActiveDirectory-Lab
 ├── README.md
 ├── screenshots
 └── architecture.png
```

---

# Resume Project Description

Built Active Directory Domain Controller in Azure, configured DNS, created client VM and joined to domain. Implemented enterprise level identity management and domain infrastructure.

---

# Author

SURAJ SHIVAJI KAMBLE
