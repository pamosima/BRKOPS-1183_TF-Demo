# Copyright (c) 2021 Cisco and/or its affiliates.

# This software is licensed to you under the terms of the Cisco Sample
# Code License, Version 1.1 (the "License"). You may obtain a copy of the
# License at

#                https://developer.cisco.com/docs/licenses

# All use of the material herein must be in accordance with the terms of
# the License. All rights not expressly granted by the License are
# reserved. Unless required by applicable law or agreed to separately in
# writing, software distributed under the License is distributed on an "AS
# IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied.

data "dnacenter_projects_details" "onboarding" {
  provider   = dnacenter
  name       = "Onboarding Configuration"
  limit = "1"
}

resource "dnacenter_configuration_template" "fiab" {
  provider = dnacenter
  parameters {
    name         = "FiAB_Onboarding-Template"
    version = "2.0"
    project_id   = data.dnacenter_projects_details.onboarding.items.0.id
    software_type    = "IOS"
    software_version = "17.6.1"
    device_types {
      product_family = "Switches and Hubs"
    }
    template_content = "hostname $HOSTNAME\n\nip routing\n\nno ip domain lookup\n\nsystem mtu 9100\nlicense boot level network-advantage addon dna-advantage\nlicense smart reservation\n\ninterface Loopback0\n description Fabric Underlay RID - do not change\n ip address $MANAGEMENT_IP_ADDRESS 255.255.255.255\n!\n!\n\nip http client source-interface Loopback0\nip http client connection forceclose\n\nip ssh server algorithm mac hmac-sha1\n!\nnetconf-yang\nrestconf"
    template_params {
        data_type        = "STRING"
        display_name     = "Hostname"
        instruction_text = "Enter a Hostname for the PnP Switch"
        not_param        = "false"
        order            = 1
        parameter_name   = "HOSTNAME"
        required = "true"
    }
        template_params {
        data_type        = "STRING"
        display_name     = "Management IP-Address"
        instruction_text = "Enter a Management IP-Address for the PnP Switch"
        not_param        = "false"
        order            = 2
        parameter_name   = "MANAGEMENT_IP_ADDRESS"
        required = "true"
    }
  }
}