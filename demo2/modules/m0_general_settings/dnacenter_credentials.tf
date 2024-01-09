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

resource "dnacenter_global_credential_cli" "global" {
  provider = dnacenter
  parameters {
    comments           = "cli-admin"
    credential_type    = "GLOBAL"
    description        = "cli-admin"
    enable_password    = "C1sco12345"
    password           = "C1sco12345"
    username           = "admin"
  }
}

resource "dnacenter_global_credential_snmpv2_read_community" "global" {
  provider = dnacenter
  parameters {
    description     = "RO"
    comments        = "RO"
    credential_type = "GLOBAL"
    read_community  = "public"
  }
}
resource "dnacenter_global_credential_snmpv2_write_community" "global" {
  provider = dnacenter
  parameters {
    description     = "RW"
    comments        = "RW"
    credential_type = "GLOBAL"
    write_community = "private"
  }
}

resource "dnacenter_global_credential_netconf" "global" {
  provider = dnacenter
  parameters {
    description        = "netconf"
    comments           = "netconf"
    credential_type    = "GLOBAL"
    netconf_port       = "830"
  }
}

resource "dnacenter_site_assign_credential" "devnet" {
  provider = dnacenter
  parameters {
    site_id           = dnacenter_area.area.item.0.id
    cli_id            = dnacenter_global_credential_cli.global.item.0.id
    snmp_v2_read_id   = dnacenter_global_credential_snmpv2_read_community.global.item.0.id
    snmp_v2_write_id  = dnacenter_global_credential_snmpv2_write_community.global.item.0.id
  }
}