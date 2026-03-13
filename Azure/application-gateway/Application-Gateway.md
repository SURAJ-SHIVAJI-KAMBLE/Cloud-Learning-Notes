Step 1. 


Create Resource Group
In Azure Portal:
Resource Group : TEST-RG
Region : East US (or your region)

Everything in the lab is deployed inside this resource group.

Step 2. 


Create Virtual Network A
Name : VNet-A
Address space : 10.0.0.0/16
Subnet : subnet-a
Subnet range : 10.0.0.0/24

This network will contain VM1.

Step 3.


Create Virtual Network B
Name : VNet-B
Address space : 10.1.0.0/16
Subnet : subnet-b
Subnet range : 10.1.0.0/24

This network will contain VM2.
Important rule:
VNet address ranges must be different

Otherwise peering will fail.

Step 4.


Create Virtual Machine 1
VM Name : VM1
OS : Ubuntu
VNet : VNet-A
Subnet : subnet-a
Private IP : 10.0.0.4

Enable:
SSH port 22
HTTP port 80

Step 5.


Connect to VM1
From your computer:
ssh snit@20.80.98.26

Now you are inside the Linux VM.

Step 6. 


Update Ubuntu Packages
sudo apt update

This refreshes the package list.

Step 7.


Install Apache Web Server
sudo apt install apache2

Apache is the software that runs websites.

Step 8. 


Enable Apache Service
sudo systemctl enable apache2

This makes Apache start automatically when the VM boots.

Step 9.

Start Apache
sudo systemctl start apache2


Step 10. 


Verify Apache Running
sudo systemctl status apache2

Output shows:
Active: active (running)

Which means the web server is working.

Step 11. 


Go to Website Folder
cd /var/www/html

Check files:
ls

Output:
index.html

This is the default Apache page.

Step 12. 


Remove Default Page
sudo rm index.html

Without sudo it fails because the directory belongs to root.

Step 13.


Create New Webpage
sudo touch index.html


Step 14. 


Edit Webpage
sudo vi index.html

Write:

Welcome to VM1

  Server 1 - VNet A

Press ESC button then shift + ; 
Then wq 
Enter

Save in vi:
ESC
:wq
ENTER


Step 15. 


Test Website
Open browser:
http://VM1-Public-IP

Example:
http://20.80.98.26

Page shows:
Welcome to VM1 
Server 1 - VNet A


Step 16. 


Create Virtual Machine 2
VM Name : VM2
VNet : VNet-B
Subnet : subnet-b
Private IP : 10.1.0.4
OS : Ubuntu


Step 17. 


Install Apache on VM2
SSH into VM2 then run:
sudo apt update
sudo apt install apache2


Step 18. 


Edit VM2 Webpage
cd /var/www/html
sudo vi index.html

Write:
Welcome to VM 2
 Server 2 - VNet B

Save and exit.

Step 19. 


Create VNet Peering
Go to VNet-A
Peer VNet-A → VNet-B

Then from VNet-B
Peer VNet-B → VNet-A

Result:
VNet-A ↔ VNet-B

Now both networks can communicate privately.


Step 20. 


Create Application Gateway
Name : TEST-AppGateway
VNet : VNet-A
Subnet : appgw-subnet
Frontend : Public IP
Frontend Port : 80

Application Gateway acts as a Layer 7 Load Balancer.



Step 21. 


Create HTTP Listener
Protocol : HTTP
Port : 80
Frontend IP : Public

Listener waits for incoming web requests.

Step 22. 


Create Backend Pool
Initially you tried:
Target Type : Virtual Machine

But only VM1 appeared.
Reason:
Application Gateway only detects VMs in the same VNet

Your setup:
VM1 → VNet-A
VM2 → VNet-B
App Gateway → VNet-A

So VM2 didn't show.

So 
1.what is Cookie based Affinity?
2.connection draining ?
3.Dedicated Backend connection?

You found three settings that sound fancy but are actually simple. Let’s keep it short and human-friendly.

1. Cookie-Based Affinity
Meaning:
Keeps a user connected to the same server every time.
Example
Without affinity:
User → VM1
Next request → VM2
Next request → VM1

With affinity enabled:
User → VM1
Next request → VM1
Next request → VM1

Used for: login sessions, shopping carts.

2. Connection Draining
When a server needs to be removed or updated, the gateway stops sending new users to it, but existing users continue until they finish.
Your setting:
Connection Draining: Enabled
Drain timeout: 1200 seconds (20 minutes)
So the gateway gives users time to finish their requests.

Uber- Example
Imagine a ride booking app like an Uber-type system.
Users are connected to VM1.
Total users connected to VM1 = 50

Now the system admin wants to remove VM1 for maintenance.
Without connection draining:
50 users suddenly disconnected
Ride requests fail
Users angry

Not great for business.

With Connection Draining Enabled
Application Gateway behavior:
VM1 is marked for removal.
Gateway stops sending new users to VM1.
Existing users continue.
Example:
Total users = 50
5 users finish their ride request
45 users still active

Flow becomes:
Old users → continue on VM1
New users → redirected to VM2

After some time:
45 → 30 → 10 → 0 users

Once users finish, VM1 can safely be removed.

3. Dedicated Backend Connection
Meaning:
Each user gets their own connection to the server.
Example
Disabled:
User1 → shared connection → VM
User2 → shared connection → VM

Enabled:
User1 → separate connection → VM
User2 → separate connection → VM

Used for some special authentication apps.

Step 23.


Add Backend using IP
You changed:
Target Type : IP Address or FQDN (Fully Qualified Domain Name)

Added:
10.0.0.4  (VM1)
10.1.0.4  (VM2)

Now backend pool contains both servers.
(Because we done peering of both VM so cant use Vm option as it wont appear )

Step 24. 


Create HTTP Settings
Protocol : HTTP
Port : 80

This defines how the gateway connects to backend servers.

Step 25. 


Create Routing Rule
Listener → Backend Pool
This rule sends traffic to:
VM1
VM2

Step 26. 


Allow NSG Rules
Allow traffic:
Port 80
Source : Application Gateway

Otherwise requests get blocked.

Step 27. 


Access Application
User open browser:
http://ApplicationGatewayPublicIP

Example:
http://20.80.98.26


Step 28.


Final Result
When refreshing the page:
First response:
Welcome to VM 1
Server 1 - VNet A

Refresh again:
Welcome to VM 2
Server 2 - VNet B

Traffic is switching between both servers.

    Final Architecture
       User Browser
            ↓
       Internet
            ↓
Application Gateway
            ↓
   Backend Pool
       ↙        ↘
  VM1             VM2
VNet-A            VNet-B
           ↔
     VNet Peering






















