
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


variable "area_name" {}
variable "area_parent_name" {}
variable "subarea_name" {}
variable "building_name" {}
variable "building_address" {}
variable "floor_name" {}
variable "floor_length" {}
variable "floor_width" {}
variable "floor_height" {}
variable "floor_rf_model" {}

variable "global_ip_pool_cidr" {}
variable "ap-pool_ipv4_subnet" {}
variable "ap-pool_ipv4_gate_way" {}
variable "ex-pool_ipv4_subnet" {}
variable "ex-pool_ipv4_gate_way" {}
variable "campus-pool_ipv4_subnet" {}
variable "campus-pool_ipv4_gate_way" {}
variable "guest-pool_ipv4_subnet" {}
variable "guest-pool_ipv4_gate_way" {}
variable "transit-pool_ipv4_subnet" {}
variable "transit-pool_ipv4_gate_way" {}
variable "lan-auto-pool_ipv4_subnet" {}
variable "lan-auto-pool_ipv4_gate_way" {}
variable "ipv4_dns_servers" {}
variable "ipv4_dhcp_servers" {}

variable "pnp_template_tags" {}
variable "device_name" {}
variable "device_hostname" {}
variable "device_pid" {}
variable "device_serial_number" {}
variable "device_management_ip_address" {}
variable "p2p_onboarding_ip_address" {}
variable "p2p_onboarding_gw" {}
variable "p2p_onboarding_vlan" {}
variable "uplink_interface_name" {}

variable "authenticate_template_name" {}

variable "vn_campus_virtual_network_name" {}
variable "vn_guest_virtual_network_name" {}