#cloud-config
runcmd:
  - 'python3 /etc/cloud_config.py generatePassword=\"${generatePassword}\" allowUploadDownload=\"${allowUploadDownload}\" templateName=\"${templateName}\" templateVersion=\"${templateVersion}\" mgmtNIC="X${mgmtNIC}X" hasInternet=\"${hasInternet}\" config_url=\"${config_url}\" config_path=\"${config_path}\" installationType="X${installationType}X" enableMonitoring=\"${enableMonitoring}\" shell=\"${shell}\" managementGUIClientNetwork=\"${managementGUIClientNetwork}\" managementNetwork=\"${managementNetwork}\"'