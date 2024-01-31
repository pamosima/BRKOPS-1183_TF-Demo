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

resource "dnacenter_reserve_ip_subpool" "pool" {
  for_each = { for pool in var.ip_pools : pool.name => pool }
  provider = dnacenter
  parameters {
    ipv4_dhcp_servers  = var.ipv4_dhcp_servers
    ipv4_dns_servers   = var.ipv4_dns_servers
    ipv4_gate_way      = "172.${each.value.subnet_id}.${var.site_id}.1"
    ipv4_global_pool   = "${var.global_ip_prefix}/${var.global_ip_prefix_length}"
    ipv4_prefix        = "true"
    ipv4_prefix_length = 24
    ipv4_subnet        = "172.${each.value.subnet_id}.${var.site_id}.0"
    ipv6_address_space = "false"
    name               = "Site-${var.site_id}-${each.value.name}"
    site_id            = dnacenter_area.subarea.item.0.id
    type               = each.value.type
  }
}
