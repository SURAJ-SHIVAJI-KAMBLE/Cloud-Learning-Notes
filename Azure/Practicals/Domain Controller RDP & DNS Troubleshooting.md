# Azure Lab — Domain Controller RDP & DNS Troubleshooting

# Lab Scenario

In this lab, we created an Azure Windows VM, configured Domain Controller, and faced RDP connection issues from another laptop. This document explains the complete troubleshooting process.

---

# Step 1 — Create Azure Windows VM

Create Virtual Machine in Azure:

Example:

* VM Name: Demo1
* OS: Windows Server 2019 / 2022
* Public IP: 20.204.248.135

Start VM

Connect using RDP:

```
mstsc /v:20.204.248.135
```

Connection Successful

---

# Step 2 — Configure Domain Controller

Install Active Directory Domain Services

Promote server to Domain Controller

Create domain:

```
Domain Name : demo.net
Server Name : Demo1
FQDN        : Demo1.demo.net
```

Restart VM after domain configuration

---

# Step 3 — Problem Started

After Domain Controller setup, students tried to connect from another laptop

Results:

* RDP File → Working
* IP Address → Not working initially
* Domain Name → Not working

---

# Step 4 — Why IP Was Not Working Initially

After Domain Controller setup, Windows changes:

* Authentication method
* Security policy
* Domain login required

Before Domain:

```
.\Administrator
```

After Domain:

```
demo.net\Administrator
```

or

```
Administrator@demo.net
```

Once correct username format used:

IP started working

Example:

```
mstsc /v:20.204.248.135
```

---

# Step 5 — Domain Name Still Not Working

Students tried connecting using:

```
mstsc /v:Demo1.demo.net
```

Error:

Remote Desktop cannot find computer

---

# Step 6 — Why Domain Name Not Working

Because:

Demo1.demo.net is internal domain

External laptop DNS does not know:

```
Demo1.demo.net
```

So DNS resolution fails

This is DNS resolution issue

---

# Step 7 — Fix Using Hosts File

Open Notepad as Administrator

Navigate to:

```
C:\Windows\System32\drivers\etc\hosts
```

Add this line at bottom:

```
20.204.248.135   Demo1.demo.net
```

Save file

---

# Step 8 — Flush DNS

Open Command Prompt as Administrator

Run:

```
ipconfig /flushdns
```

---

# Step 9 — Test Connection

Now connect using:

```
mstsc /v:Demo1.demo.net
```

Connection Successful

---

# Final Result

* RDP File → Working
* IP Address → Working
* Domain Name → Working

---

# What Students Learned

* Azure VM Creation
* Domain Controller Setup
* RDP Connection
* DNS Resolution
* FQDN Concept
* Hosts File
* Troubleshooting

---

# Important Real-World Concept

In enterprise environments:

Servers use domain names such as:

```
server.company.local
```

Without DNS configuration:

Connection fails

With DNS:

Connection works

---

# Summary

1. Create Azure VM
2. Connect using RDP
3. Configure Domain Controller
4. IP initially fails
5. Fix authentication
6. IP works
7. Domain name fails
8. Add hosts file
9. Domain name works

---

End of Azure Lab
