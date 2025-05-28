---
title: Unified Experience Secure Link Setup - ServiceNow & Genesys Cloud  
author: iyin.raphael 
indextype: blueprint  
icon: blueprint  
image: images/secure_link_flow.png  
category: 5  
summary: |
  This Genesys Cloud Developer Blueprint demonstrates how to automate the end-to-end setup of a secure OAuth/JWT communication link between ServiceNow and Genesys Cloud using Terraform modules (CX-as-Code) and OpenSSL.
---

## Overview

This blueprint automates the manual steps required to establish a secure, OAuth-based integration between ServiceNow and Genesys Cloud into reusable, version-controlled Terraform modules. By leveraging the Genesys Cloud CX-as-Code and Terraform providers alongside OpenSSL, teams can deploy a consistent communication link in minutes.

![Secure Link Flow](/blueprint/images/flow_archi.png)

## Solution Components

- **Genesys Cloud CX-as-Code Terraform Provider**  
  Automates creation of OAuth clients, roles, and secrets in Genesys Cloud.  
- **Terraform Provider**  
  Manages X.509 certificates, Application Registry entries, integration users, and Connection & Credential Aliases in ServiceNow.  
- **OpenSSL**  
  CLI tool invoked via a Terraform provisioner to generate self-signed certificates.  
- **Terraform Modules**  
  - `certs` – generates self-signed key and certificate.  
  - `genesys` – provisions Genesys Cloud OAuth client, secret, and role assignments.  
  - `servicenow` – registers the certificate, creates the application registry, configures JWT verification, creates an integration user, and establishes Connection & Credential Aliases.

## Prerequisites

1. **Terraform v1.3+** installed locally  
2. **OpenSSL** CLI installed  
3. **ServiceNow Instance** with Admin privileges  
4. **Genesys Cloud CX** tenant with Admin or Integrations role

### Required Configuration Values

- **ServiceNow**  
  - `sn_instance_url`  
  - `sn_username`  
  - `sn_password`  
- **Genesys Cloud**  
  - `genesyscloud_region`  
  - `division_id`  
  - `role_id`  
- **OAuth Client**  
  - `oauth_client_name`  
  - `oauth_token_validity_seconds`  
  - `oauth_name`
- **Certificate**  
  - `common_name`  
  - `organization`  
  - `validity_days`  
  - `cert_password`  
  - `cert_name`  
  - `jwt_verifier_name`  
- **Integration User**  
  - `integration_user_id`  
  - `integration_user_first_name`  
  - `integration_user_last_name`  
- **Connection Alias**  
  - `connection_alias`  
  - `genesys_api_url`

## Repository Structure

```text
├── main.tf      
├── provider.tf      
├── variables.tf      
├── outputs.tf        
├── certs/             
│   ├── resources.tf
│   ├── variables.tf
│   └── outputs.tf
├── genesys/           
│   ├── resources.tf
│   ├── variables.tf
│   └── outputs.tf
└── servicenow/       
    ├── resources.tf
    ├── variables.tf
    └── outputs.tf
```

## Run Terraform to set up Genesys Cloud and ServiceNow
1. **Clone the repository**
  ```{"language":"bash"}
  git clone https://github.com/GenesysCloudBlueprints/nowue-automating-secure-communication-link-setup.git
  cd nowue-automating-secure-communication-link-setup
  ```

2. **Set Genesys Cloud credential environmetn variable** (MacOS)
  ```{"language":"bash"}
    export GENESYSCLOUD_OAUTHCLIENT_ID="your-client-id"
    export GENESYSCLOUD_OAUTHCLIENT_SECRET="your-client-secret"
    export GENESYSCLOUD_REGION="us_east_1" 
  ```

3. **Create `terraform.tfvars` in root folder**
  - Create a Role with the following permissions in Genesys Cloud:
    - i. Integration > cxCloudSN > Add, Edit, View, and Delete
    - ii. Conversation > *
    - iii. Messaging > *
    - Add role id value
      ```{"language":"bash"}
        role_id  = "12345678-90ab-cdef-1234-567890abcdef"
      ```
  - Terraform oauth details for Genesys Cloud **used in the sub module not root module, for root module set Environment variable**
    ```{"language":"bash"}
      oauthclient_id                    = "34567eda-a03re-45tg-acvb-23e3dnmknahs"
      oauthclient_secret                = "dscdscdUUc8JxV5kF4R6BBmGSIHJIOOXSSXSXS"
    ```
  - Genesys Cloud region, oauth client values
    ```{"language":"bash"}
      genesyscloud_region           = "us_east_1"
      oauth_client_name             = "sn-gc-integration-client"
      division_id                   = "abcdef12-3456-7890-abcd-ef1234567890"
      genesys_api_url               = "https://api.mypurecloud.com"
    ```     
  - ServiceNow Org URL, username and password
    ```{"language":"bash"}
      sn_instance_url               = "dev12345.service-now.com"
      sn_username                   = "admin"
      sn_password                   = "SuperSecret"
    ```
   - Get Sys ID for Installed Connection Alias in ServiceNow
     - Navigate to Integration Hub > Connections & Credentials Aliases
     - Open the “Genesys Cloud” record (created and installed as part of the plugin ID: **x_inics_gen_core.Genesys_Cloud**)
     - Copy sys_id
      ![Sys_id](/blueprint/images/credentials_sys_id.png)
     - input sys_id
        ```{"language":"bash"}
          connection_alias              = "452389238y23e8y23ey8777"
        ```
  - User details in ServiceNow
    ```{"language":"bash"}
      integration_user_id           = "svc_genesys_sn"
      integration_user_first_name   = "Genesys"
      integration_user_last_name    = "ServiceNow"
    ```
  - Certs credentials 
    ```{"language":"bash"}
      cert_password                 = "CertPass123!"
      cert_name                     = "GC-SN-SecureCert"
      common_name                   = "svc-genesys-sn"
      organization                  = "MyCompany"
    ```
  - JWT info
    ```{"language":"bash"}
      validity_days                 = 365
      jwt_verifier_name             = "GC-SN-JWT-Verify"
      oauth_name                    = "unified_experience_jwt_oauth_endpoint"
    ```
4. **Initialize Terraform**
     ```{"language":"bash"}
       terraform init
     ```
5. **Review the execution plan**
     ```{"language":"bash"}
       terraform plan
     ```
6. **Apply the configuration**
    ```{"language":"bash"}
       terraform apply
    ```
7. **Verify**