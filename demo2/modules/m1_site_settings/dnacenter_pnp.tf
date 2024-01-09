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


data "dnacenter_configuration_template" "pnp_template" {
  provider       = dnacenter
  latest_version = "false"
  software_version = "17.6.1"
  un_committed     = "true"
}

data "dnacenter_pnp_device" "device" {
  provider           = dnacenter
  serial_number      = [ var.device_serial_number ]
}

data "dnacenter_site" "building" {
  provider = dnacenter
  name = "${dnacenter_building.building.parameters.0.site.0.building.0.parent_name}/${dnacenter_building.building.parameters.0.site.0.building.0.name}"
}

resource "dnacenter_pnp_device_site_claim" "device" {
  provider          = dnacenter
  parameters {
    device_id       = data.dnacenter_pnp_device.device.items.0.id
    site_id         = data.dnacenter_site.building.items.0.id
    type            = "Default"
    image_info {
      image_id = ""
      skip     = "true"
    }
    config_info {
      config_id = data.dnacenter_configuration_template.pnp_template.items.0.template_id
      config_parameters {
        key   = "HOSTNAME"
        value = var.device_hostname
      }
      config_parameters {
        key   = "MANAGEMENT_IP_ADDRESS"
        value = "172.31.${var.site_id}.1"
      }
      config_parameters {
        key   = "P2P_ONBOARDING_IP_ADDRESS"
        value = "172.20.${var.site_id}.2"
      }     
      config_parameters {
        key   = "P2P_ONBOARDING_GW"
        value = "172.20.${var.site_id}.1"
      }
      config_parameters {
        key   = "P2P_ONBOARDING_VLAN"
        value = "20"
      }

      config_parameters {
        key   = "UPLINK_INTERFACE_NAME"
        value = var.uplink_interface_name
      }      
    }
  }
}

data "external" "onboarding_state" {
  depends_on = [ dnacenter_pnp_device_site_claim.device ]
  program = ["python3", "dnac_state.py"]

  query = {
    serial_number = var.device_serial_number
  }
}