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

data "thousandeyes_agent" "catalyst9k" {
  depends_on = [time_sleep.wait4agent]
  agent_name = ciscoapphosting_app.thousandeyes.hostname
}

resource "thousandeyes_http_server" "webex_http_test" {
  provider  = thousandeyes
  test_name = "Terraform - cisco.webex.com"
  interval  = 120
  url       = "https://cisco.webex.com"
  agents {
    agent_id = data.thousandeyes_agent.catalyst9k.agent_id
  }
  alerts_enabled = false
}