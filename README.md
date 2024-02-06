# BRKOPS-1183 TF-Demo Files

_Introduction to Infrastructure as Code for Cisco Catalyst Center with Terraform_

---

Building and managing Cisco SD-Access fabric doesn't have to be challenging or complex! You just need to use the right approach and toolset. Terraform is an open-source infrastructure as code software tool created by HashiCorp. The dnacenter Terraform provider leverages the Cisco Catalyst Center APIs for managing and automating your Cisco Catalyst Center environment. This will reduce the overall time to create, change and delete fabric sites while delivering consistent outcomes of each fabric configuration step. This session will demonstrate step-by-step how to deploy a Cisco SD-Access fabric from scratch using Terraform together with Cisco Catalyst Center.

## Requirements
---

* `Terraform 0.13+`
* Provider: `dnacenter >= 1.1.31-beta`

## Features
---
### Demo 1
* Create Site 

### Demo 2
* Configure General Settings
* Create Site 
* Onboard FiAB (PnP)
* Create Fabric Site
* Run pyATS test


## Solution Components - Cisco Products / Licenses

This module can be used with Cisco Catalyst Center

## Usage & Installation

Clone this repository to a machine that is able to connect to your Cisco CatalystCa Center instance url:

    git clone https://github.com/pamosima/BRKOPS-1183-TF-Demo

Create an api-user account on Cisco Catalyst Center. Modify the `terraform.tfvars` with the corresponding values:

    dnac_username = "dnac_username"
    dnac_password = "dnac_password"
    dnac_url= "https://dnac-fqdn.top"


Start with the standard terraform flow by running terraform init, plan & apply.

## Issues/Comments

Please post any issues or comments directly on GitHub.
