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

# Declare required provider
provider "dnacenter" {

    username = var.dnac_username
    password = var.dnac_password
    base_url = var.dnac_url
    debug = "true"
    ssl_verify = "false"
}

resource "dnacenter_site" "area_a" {
  provider = dnacenter
  parameters {
    site {
      area {
        name = "Area A"
        parent_name = var.parent_name
      }
    }
  type = "area"
  }
}
