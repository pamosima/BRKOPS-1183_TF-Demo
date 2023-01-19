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

resource "dnacenter_global_pool" "default" {
  provider = dnacenter
  parameters {
    settings {
      ippool {

        ip_address_space = "IPv4"
        ip_pool_cidr     = var.global_ip_pool_cidr
        ip_pool_name     = "Global_${var.subarea_name}"
        type             = "Generic"
      }
    }
  }
}

resource "dnacenter_reserve_ip_subpool" "transit-pool" {
  depends_on = [ dnacenter_global_pool.default ]
  provider = dnacenter
  parameters {

    ipv4_dhcp_servers  = var.ipv4_dhcp_servers
    ipv4_dns_servers   = var.ipv4_dns_servers
    ipv4_gate_way      = var.transit-pool_ipv4_gate_way
    ipv4_global_pool   = var.global_ip_pool_cidr
    ipv4_prefix        = "true"
    ipv4_prefix_length = 25
    ipv4_subnet        = var.transit-pool_ipv4_subnet
    ipv6_address_space = "false"
    name               = "${var.subarea_name}-Transit-Pool"
    site_id            = dnacenter_site.subarea.item.0.id
    type               = "Generic"
  }
}

resource "dnacenter_reserve_ip_subpool" "lan-auto-pool" {
  depends_on = [ dnacenter_global_pool.default ]
  provider = dnacenter
  parameters {

    ipv4_dhcp_servers  = var.ipv4_dhcp_servers
    ipv4_dns_servers   = var.ipv4_dns_servers
    ipv4_gate_way      = var.lan-auto-pool_ipv4_gate_way
    ipv4_global_pool   = var.global_ip_pool_cidr
    ipv4_prefix        = "true"
    ipv4_prefix_length = 25
    ipv4_subnet        = var.lan-auto-pool_ipv4_subnet
    ipv6_address_space = "false"
    name               = "${var.subarea_name}-LAN-Auto-Pool"
    site_id            = dnacenter_site.subarea.item.0.id
    type               = "LAN"
  }
}

resource "dnacenter_reserve_ip_subpool" "campus-pool" {
  depends_on = [ dnacenter_global_pool.default ]
  provider = dnacenter
  parameters {

    ipv4_dhcp_servers  = var.ipv4_dhcp_servers
    ipv4_dns_servers   = var.ipv4_dns_servers
    ipv4_gate_way      = var.campus-pool_ipv4_gate_way
    ipv4_global_pool   = var.global_ip_pool_cidr
    ipv4_prefix        = "true"
    ipv4_prefix_length = 24
    ipv4_subnet        = var.campus-pool_ipv4_subnet
    ipv6_address_space = "false"
    name               = "${var.subarea_name}-Campus-Pool"
    site_id            = dnacenter_site.subarea.item.0.id
    type               = "Generic"
  }
}

resource "dnacenter_reserve_ip_subpool" "guest-pool" {
  depends_on = [ dnacenter_global_pool.default ]
  provider = dnacenter
  parameters {

    ipv4_dhcp_servers  = var.ipv4_dhcp_servers
    ipv4_dns_servers   = var.ipv4_dns_servers
    ipv4_gate_way      = var.guest-pool_ipv4_gate_way
    ipv4_global_pool   = var.global_ip_pool_cidr
    ipv4_prefix        = "true"
    ipv4_prefix_length = 24
    ipv4_subnet        = var.guest-pool_ipv4_subnet
    ipv6_address_space = "false"
    name               = "${var.subarea_name}-Guest-Pool"
    site_id            = dnacenter_site.subarea.item.0.id
    type               = "Generic"
  }
}

resource "dnacenter_reserve_ip_subpool" "ap-pool" {
  depends_on = [ dnacenter_global_pool.default ]
  provider = dnacenter
  parameters {

    ipv4_dhcp_servers  = var.ipv4_dhcp_servers
    ipv4_dns_servers   = var.ipv4_dns_servers
    ipv4_gate_way      = var.ap-pool_ipv4_gate_way
    ipv4_global_pool   = var.global_ip_pool_cidr
    ipv4_prefix        = "true"
    ipv4_prefix_length = 25
    ipv4_subnet        = var.ap-pool_ipv4_subnet
    ipv6_address_space = "false"
    name               = "${var.subarea_name}-AP-Pool"
    site_id            = dnacenter_site.subarea.item.0.id
    type               = "Generic"
  }
}

resource "dnacenter_reserve_ip_subpool" "ex-pool" {
  depends_on = [ dnacenter_global_pool.default ]
  provider = dnacenter
  parameters {

    ipv4_dhcp_servers  = var.ipv4_dhcp_servers
    ipv4_dns_servers   = var.ipv4_dns_servers
    ipv4_gate_way      = var.ex-pool_ipv4_gate_way
    ipv4_global_pool   = var.global_ip_pool_cidr
    ipv4_prefix        = "true"
    ipv4_prefix_length = 25
    ipv4_subnet        = var.ex-pool_ipv4_subnet
    ipv6_address_space = "false"
    name               = "${var.subarea_name}-EX-Pool"
    site_id            = dnacenter_site.subarea.item.0.id
    type               = "Generic"
  }
}