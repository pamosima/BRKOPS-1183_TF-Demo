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

resource "ciscoapphosting_iox" "iox" {
  host                 = var.device_management_ip_address
  enable               = true
}

resource "ciscoapphosting_app" "thousandeyes" {
  depends_on = [
    ciscoapphosting_iox.iox
  ]
  host                 = var.device_management_ip_address
  name                 = "thousandeyes"
  image                = "http://192.168.99.103/thousandeyes-enterprise-agent-4.2.2.cisco.tar"
  app_gigabit_ethernet = "1/0/1"
  vlan_trunk           = true
  vlan                 = 1021
  env = {
    TEAGENT_ACCOUNT_TOKEN = var.te_agent_token
  }
}

resource "time_sleep" "wait" {
  depends_on      = [ciscoapphosting_app.thousandeyes]
  create_duration = "240s"
}
