# AWS EC2 Mini Practical (EC2 + AMI + EBS + Snapshot)

## Step 1: Launch EC2 Instance

* Go to AWS Console → EC2 → Launch Instance
* Choose AMI: Amazon Linux
* Instance type: t2.micro
* Create/select key pair
* Enable public IP
* Click **Launch Instance**

---

## Step 2: Connect to EC2 & Access Metadata (IMDSv2)

### Get Token

```
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
-H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
```

### Fetch Instance ID

```
curl -H "X-aws-ec2-metadata-token: $TOKEN" \
http://169.254.169.254/latest/meta-data/instance-id
```

---

## Step 3: Create Variables

### Simple Variable

```
export ENV=dev
echo $ENV
```

### Store Instance ID in Variable

```
export INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
http://169.254.169.254/latest/meta-data/instance-id)

echo $INSTANCE_ID
```

---

## Step 4: Create AMI from Instance

* Go to EC2 → Instances
* Select instance
* Click **Actions → Image → Create Image**
* Give name → Create AMI

---

## Step 5: Create and Attach EBS Volume

### Create Volume

* Go to EC2 → Volumes → Create Volume
* Size: 8 GB
* Availability Zone: Same as EC2

### Attach Volume

* Select volume → Actions → Attach Volume
* Choose instance
* Device name: /dev/sdf

---

## Step 6: Verify and Mount Volume

### Check attached disk

```
lsblk
```

### Format disk

```
sudo mkfs -t ext4 /dev/xvdf
```

### Create mount directory

```
sudo mkdir /mnt/data
```

### Mount volume

```
sudo mount /dev/xvdf /mnt/data
```

### Verify

```
df -h
```

---

## Step 7: Create Snapshot

* Go to EC2 → Volumes
* Select attached volume (/dev/sdf)
* Click **Actions → Create Snapshot**
* Give name → Create

---

## Step 8: (Optional) Permanent Mount using fstab

### Get UUID

```
sudo blkid
```

### Edit fstab

```
sudo vi /etc/fstab
```

### Add entry

```
UUID=<your-uuid> /mnt/data ext4 defaults,nofail 0 2
```

### Test

```
sudo mount -a
```

---

# End of Practical
