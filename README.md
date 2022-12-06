# BRKOPS-1183 TF-Demo Files

_Introduction to Infrastructure as Code for Cisco DNA Center with Terraform_

---

Building and managing Cisco SD-Access fabric doesn't have to be challenging or complex! You just need to use the right approach and toolset. Terraform is an open-source infrastructure as code software tool created by HashiCorp. The dnacenter Terraform provider leverages the Cisco DNA Center APIs for managing and automating your Cisco DNA Center environment. This will reduce the overall time to create, change and delete fabric sites while delivering consistent outcomes of each fabric configuration step. This session will demonstrate step-by-step how to deploy a Cisco SD-Access fabric from scratch using Terraform together with Cisco DNA Center.

## Requirements
---

* `Terraform 0.13+`
* Provider: `dnacenter >= 1.0.12-beta` `ciscoapphosting >= 1.0.0` `thousandeyes >= 1.0.0-beta` `time >= 0.8.0`

## Features
---

* Configure General Settings
* Configure Site 
* Onboard FiAB (PnP)
* Create Fabric Site
* Deploy TE agent on FiAB
* Create TE test and attach FiAB to TE test


## Solution Components - Cisco Products / Licenses

This module can be used with Cisco DNA Center, Catalyst 9300 & ThousandEyes Dashboard

## Usage & Installation

Clone this repository to a machine that is able to connect to your Cisco DNA Center instance url:

    git clone https://github.com/pamosima/BRKOPS-1183-TF-Demo

Create your Fabric configuration by copying one of the included examples. First you need to use example_its-best_general and then example_its-best_zurich:

    cp -r infra/example_its-best-general infra/my-new-fabric_general
    cd infra/my-new-fabric_general

    cp -r infra/example_its-best-zurich infra/my-new-fabric_location
    cd infra/my-new-fabric_location

Edit `variable.tf` file from `infra/my-new-fabric_general` and `infra/my-new-fabric_location`. This should be the only files in which you describe the parameters for your fabric site. Go through all the values carefully and make sure you get all parameters right before triggering a deployment. Some values cannot be changed after a fabric is deployed and will require a complete fabric reinstallation.

Create an api-user account on Cisco DNA Center and get your tokens from ThousandEyes Dashboard. Create a `terraform.tfvars` file in `infra/my-new-fabric_general` and `infra/my-new-fabric_location` with the corresponding values:

    dnac_username = "dnac_username"
    dnac_password = "dnac_password"
    dnac_url= "https://dnac-fqdn.top"

    ios_xe_username = "ios_xe_username"
    ios_xe_password = "ios_xe_password"

    te_token = "te_token"
    te_agent_token = "te_agent_token"

Start with the standard terraform flow by running terraform init, plan & apply.

## Issues/Comments

Please post any issues or comments directly on GitHub.
