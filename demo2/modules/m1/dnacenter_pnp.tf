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

resource "dnacenter_pnp_device" "device" {
  provider = dnacenter
  parameters {

    device_info {

      name        = var.device_name
      hostname = var.device_hostname
      pid         = var.device_pid
      serial_number    = var.device_serial_number
      location {
        site_id   = dnacenter_site.building.item.0.id
      }
    }
  }
  lifecycle {
    ignore_changes = [ parameters ]
  }
}



data "dnacenter_configuration_template" "pnp_template" {
  provider       = dnacenter
  latest_version = "false"
  tags           = var.pnp_template_tags
}

data "dnacenter_pnp_device" "device" {
  depends_on = [ dnacenter_pnp_device.device ]
  provider           = dnacenter
  hostname    = var.device_hostname
}

data "dnacenter_swim_image_details" "device" {
  provider                = dnacenter
  is_tagged_golden        = "true"
  # name = "cat9k_iosxe.17.08.01.SPA.bin"
  family = "CAT9K"
  limit                   = 1
}

resource "dnacenter_pnp_device_site_claim" "device" {
  depends_on = [ dnacenter_pnp_device.device ]
  provider = dnacenter
  parameters {
    device_id = data.dnacenter_pnp_device.device.items.0.id
    site_id   = dnacenter_site.building.item.0.id
    hostname  = var.device_hostname
    type      = "Default"
    image_info {
      image_id = data.dnacenter_swim_image_details.device.items.0.image_uuid
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
        value = var.device_management_ip_address
      }
    }
  }
}