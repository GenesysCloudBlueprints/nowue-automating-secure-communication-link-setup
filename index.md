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