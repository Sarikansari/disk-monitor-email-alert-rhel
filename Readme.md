Here’s a well-structured and professional GitHub project write-up for your **Disk Space Monitor with Email Alert Script for RHEL**. You can copy this into your `README.md` file on GitHub to showcase your work effectively.

---

### ✅ GitHub Repository Name:

`disk-monitor-email-alert-rhel`

---

### 📄 Project Description

> This project is a Bash script designed for **Red Hat Enterprise Linux (RHEL)** systems to monitor disk usage on a specified partition (e.g., `/dev/nvme0n1p2`) and automatically **send an email alert** when usage crosses a defined threshold. It uses `mailx` and `Postfix` to notify system admins or clients of low disk space.

---

### 📁 Project Structure

```
disk-monitor-email-alert-rhel/
├── disk_alert.sh
└── README.md
```

---

### 📜 Script: `disk_alert.sh`

```bash
#!/bin/bash

# Monitoring disk space on /dev/nvme0n1p2
FU=$(df -h | grep "nvme0n1p2" | awk '{print $5}' | tr -d %)
TO="ansarisarik748@gmail.com"

if [[ $FU -ge 80 ]]
then
    echo "Warning, disk space is low - $FU %" | mail -s "Disk SPACE ALERT!" $TO
else
    echo "Disks are in good"
fi
```

---

### ⚙️ How It Works

* Uses `df -h` to check disk usage in human-readable format.
* Filters the target partition using `grep` and extracts the usage percent using `awk` and `tr`.
* Compares the disk usage to a threshold (default: `80%`).
* If usage exceeds the threshold, an email alert is sent using `mailx`.

---

### 🧪 Sample Output

```bash
[root@localhost projects]# df -h | grep "nvme0n1p2"
/dev/nvme0n1p2        1014M  489M  526M  49% /boot

[root@localhost projects]# ./disk_alert.sh
Disks are in good
```

If usage exceeds 80%:

```
Email sent: "Disk SPACE ALERT! - Warning, disk space is low - 85%"
```

---

### 🛠️ Prerequisites

To enable email alerts, **Postfix and mailx** must be configured on your RHEL system.

---

### ✅ Postfix Setup Guide (for Gmail SMTP)

#### 1. Install Postfix & Mailx

```bash
sudo dnf install -y postfix mailx
```

#### 2. Enable and Start Postfix

```bash
sudo systemctl enable postfix
sudo systemctl start postfix
```

#### 3. Configure Postfix (Gmail SMTP Example)

Edit the config file:

```bash
sudo nano /etc/postfix/main.cf
```

Add the following lines:

```
relayhost = [smtp.gmail.com]:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_tls_CAfile = /etc/ssl/certs/ca-bundle.crt
```

#### 4. Create the SASL Password File

```bash
sudo nano /etc/postfix/sasl_passwd
```

Add:

```
[smtp.gmail.com]:587    your_email@gmail.com:your_app_password
```

> 💡 Use an **App Password** from your Google account:
> [https://myaccount.google.com/apppasswords](https://myaccount.google.com/apppasswords)

#### 5. Secure Credentials

```bash
sudo postmap /etc/postfix/sasl_passwd
sudo chmod 600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
```

#### 6. Restart Postfix

```bash
sudo systemctl restart postfix
```

#### 7. Test Email Sending

```bash
echo "Test disk alert" | mail -s "Disk Alert Test" your_email@gmail.com
```

---

### 🧠 Customization Options

* **Change Partition**: Replace `"nvme0n1p2"` with any mounted partition name.
* **Change Threshold**: Modify `80` to any % value based on requirement.
* **Multiple Partitions**: Extend the script to check multiple disks.
* **Logging**: Add logging functionality for historical checks.

---

### 🌀 Automation (Optional)

To run the script periodically, add it to `cron`:

```bash
crontab -e
```

Add:

```
*/30 * * * * /path/to/disk_alert.sh
```

This runs the check every 30 minutes.

---

### 📌 Final Notes

* This script is ideal for servers with limited partition space like `/boot` or `/var`.
* The email alert ensures proactive disk space monitoring and system stability.
* Fully compatible with **RHEL, CentOS**, and **Fedora** systems.

---

Let me know if you'd like me to help you turn this into a ZIP for upload or assist in extending it with logging or multi-partition support.
