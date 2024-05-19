#!/bin/bash
# Install Nginx
sudo apt install nginx -y
#Install Azure
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
# Azure CLI Login with Managed Identity
az login --identity -u /subscriptions/9ea6c168-cf8c-47a6-a689-a7c35990bf7f/resourcegroups/WebserverRG/providers/Microsoft.ManagedIdentity/userAssignedIdentities/tostorageuami
# Download blob
sudo az storage blob download  --container-name mydemoctl --account-name stg8demo --name index.html --file /var/www/html/index.html
# Restart Nginx Service
sudo systemctl restart nginx 

# Provide by CHATGPT
#!/bin/bash

# # Install Nginx
# #!/bin/bash

# # Install Nginx
# sudo apt install nginx -y || { echo "Nginx installation failed"; exit 1; }

# # Install Azure CLI if not installed
# if ! command -v az &> /dev/null
# then
#     curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash || { echo "Azure CLI installation failed"; exit 1; }
# fi

# # Azure CLI Login with Managed Identity
# az login --identity -u /subscriptions/9ea6c168-cf8c-47a6-a689-a7c35990bf7f/resourcegroups/WebserverRG/providers/Microsoft.ManagedIdentity/userAssignedIdentities/tostorageuami || { echo "Azure login failed"; exit 1; }

# # Wait for a short period to ensure the login is processed
# sleep 10

# # Verify login by listing accounts
# az account list -o table || { echo "Failed to list Azure accounts"; exit 1; }

# # Download blob
# sudo az storage blob download --container-name mydemoctl --account-name stg8demo --name index.html --file /var/www/html/index.html

# # Restart Nginx
# sudo systemctl restart nginx 

