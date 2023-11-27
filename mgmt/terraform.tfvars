# --- Google Provider ---
service_account_path                        = "../../chkp-gcp-sales-ccurrier-box-5e4062df1d80.json"
project                                     = "chkp-gcp-sales-ccurrier-box"

# --- Check Point Deployment---
image_name                                  = "check-point-r8120-byol-631-991001383-v20230907"  #"check-point-r8120-byol"
installationType                            = "Management only"
license                                     = "BYOL"
prefix                                      = "da"
management_nic                              = "Ephemeral Public IP (eth0)"
admin_shell                                 = "/bin/bash"
generatePassword                            = false
allowUploadDownload                         = true
ssh_key                                      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCySJ1cDHVfRaaekqdWbIBDQwzH/P/Qph2jmfb87sKLZYNkxxykajIWHuTH5pQrWhOAXeoHwA6D+ttZFJDmcsXujS0k82u/8S34xJRXUAgmuSFmSMlHIf6bNcZepdwusQsrniSSDhLpQpwILWIYDg3+j658ORWwPou8xHe3W2FtyE2MyGfB6HoxJPlV+2xF3i32ip3DSiNgV+B4zaM36BfvJB0fuZMrNAwwyTWBTRg/KDu9kjkxqsooEaTdJQUoWGVToKZ89r7Eqgqj6IpUaXBoqqJfk+bCzbHMwS0LbfWODj+9SF0t9qxu6rBOcucK+yamEjRABHY+9/obIBEuBkCenvWpKrs9hL6o6eoKchBeut+kYYIUlJrfrNkqGTmDJHJ477u9OPMwEiknwaS7g4LilVe7jVggXACUozF5O2VKnoyM2iZ1i3S83zy9uN4/i5wOuusDGRrbWuPzxp9T3wuDi2SZ54jhzzH6QycOQfThv0uPIfB8nL1iP+Q9LsW8g2c= gcp-pi"
managementGUIClientNetwork                  = "0.0.0.0/0"

# --- Networking---
zone                                        = "us-east4-a"
externalIP                                  = "static"
mgmt_ip                                     = "10.50.0.100"

# --- Instances configuration---
machine_type                                = "n1-standard-4"
diskType                                    = "SSD Persistent Disk"
bootDiskSizeGb                              = 100
enableMonitoring                            = false
