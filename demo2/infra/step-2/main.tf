
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

module "m1_site_settings" {
  # Using m1_site_settings module to configure site settings
  source = "../../modules/m1_site_settings"

  area_name = var.area_name  
  area_parent_name = var.area_parent_name
  subarea_name = var.subarea_name
  building_name = var.building_name
  building_address = var.building_address
  floor_name = "${var.building_name}-1"
  floor_length = "100"
  floor_width = "100"
  floor_height = "100"
  floor_rf_model = "Cubes And Walled Offices"

  site_id = var.site_id
  
  global_ip_prefix = "172.16.0.0"
  global_ip_prefix_length = "12"
  ipv4_dhcp_servers = ["100.127.0.2"]
  ipv4_dns_servers = ["192.168.99.111", "192.168.99.112"]
  ip_pools = var.ip_pools

  device_name = var.device_hostname
  device_hostname = var.device_hostname
  device_pid = var.device_pid
  device_serial_number = var.device_serial_number

  uplink_interface_name = "GigabitEthernet1/0/1"

  authenticate_template_name = "No Authentication"

  vn_campus_virtual_network_name = "Campus_VN"
  vn_guest_virtual_network_name = "Guest_VN"
}

module "m2_provision" {
  # Using m2_provision module to provision FiAB
  depends_on = [ module.m1_site_settings ]
  source = "../../modules/m2_provision"

  area_name = var.area_name  
  area_parent_name = var.area_parent_name
  subarea_name = var.subarea_name
  building_name = var.building_name

  site_id = var.site_id

  device_hostname = var.device_hostname
  device_serial_number = var.device_serial_number
  external_as_number = var.external_as_number
  internal_as_number = var.internal_as_number
  p2p_infra-vn_vlan = "3${var.site_id}1"
  p2p_campus-vn_vlan = "3${var.site_id}2"
  p2p_guest-vn_vlan = "3${var.site_id}3"
  uplink_interface_name = "GigabitEthernet1/0/1"

  vn_campus_virtual_network_name = "Campus_VN"
  vn_guest_virtual_network_name = "Guest_VN"
}

# module "m3_testing" {
#   # Using m3_testing module to deploy TE-Agent
#   depends_on = [ module.m2_provision ]
#   source = "../../modules/m3_testing"

#   device_management_ip_address = var.device_management_ip_address

#   te_agent_token = var.te_agent_token
#   te_token = var.te_token
# }
