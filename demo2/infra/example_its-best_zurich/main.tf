
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

provider "ciscoapphosting" {
  username = var.ios_xe_username
  password = var.ios_xe_password
  insecure = var.insecure
  timeout  = var.timeout
}

provider "thousandeyes" {
  token = var.te_token
}

module "m1_site_settings" {
  # Using m1_site_settings module to configure site settings
  source = "../../modules/m1_site_settings"

  area_name = var.area_name  
  area_parent_name = var.area_parent_name
  subarea_name = var.subarea_name
  global_ip_pool_cidr = "${var.ip_pool_prefix}0.0/16"
  building_name = var.building_name
  building_address = var.building_address
  floor_name = "${var.building_name}-1"
  floor_length = "100"
  floor_width = "100"
  floor_height = "100"
  floor_rf_model = "Cubes And Walled Offices"
  
  ap-pool_ipv4_subnet = "${var.ip_pool_prefix}255.0"
  ap-pool_ipv4_gate_way = "${var.ip_pool_prefix}255.1"
  ex-pool_ipv4_subnet = "${var.ip_pool_prefix}255.128"
  ex-pool_ipv4_gate_way = "${var.ip_pool_prefix}255.129"
  guest-pool_ipv4_subnet = "${var.ip_pool_prefix}120.0"
  guest-pool_ipv4_gate_way = "${var.ip_pool_prefix}120.1"
  campus-pool_ipv4_subnet = "${var.ip_pool_prefix}100.0"
  campus-pool_ipv4_gate_way = "${var.ip_pool_prefix}100.1"
  lan-auto-pool_ipv4_subnet = "${var.ip_pool_prefix}254.128"
  lan-auto-pool_ipv4_gate_way = "${var.ip_pool_prefix}254.129"
  transit-pool_ipv4_subnet = "${var.ip_pool_prefix}254.0"
  transit-pool_ipv4_gate_way = "${var.ip_pool_prefix}254.1"
  ipv4_dhcp_servers = ["100.127.0.2"]
  ipv4_dns_servers = ["192.168.99.111", "192.168.99.112"]

  pnp_template_tags = ["${var.area_name}"]
  device_name = var.device_hostname
  device_hostname = var.device_hostname
  device_management_ip_address = var.device_management_ip_address
  device_pid = var.device_pid
  device_serial_number = var.device_serial_number
  p2p_onboarding_ip_address = var.p2p_onboarding_ip_address
  p2p_onboarding_gw = var.p2p_onboarding_gw
  uplink_interface_name = var.uplink_interface_name
  p2p_onboarding_vlan = var.p2p_onboarding_vlan  

  authenticate_template_name = "Closed Authentication"

  vn_campus_virtual_network_name = var.vn_campus_virtual_network_name
  vn_guest_virtual_network_name = var.vn_guest_virtual_network_name
}

# module "m2_provision" {
#   # Using m2_provision module to provision FiAB
#   depends_on = [ module.m1_site_settings ]
#   source = "../../modules/m2_provision"

#   area_name = var.area_name  
#   area_parent_name = var.area_parent_name
#   subarea_name = var.subarea_name
#   building_name = var.building_name

#   device_hostname = var.device_hostname
#   device_management_ip_address = var.device_management_ip_address
#   external_as_number = var.external_as_number
#   internal_as_number = var.internal_as_number
#   p2p_infra-vn_vlan = var.p2p_infra-vn_vlan
#   p2p_campus-vn_vlan = var.p2p_campus-vn_vlan
#   p2p_guest-vn_vlan = var.p2p_guest-vn_vlan
#   uplink_interface_name = var.uplink_interface_name

#   vn_campus_virtual_network_name = var.vn_campus_virtual_network_name
#   vn_guest_virtual_network_name = var.vn_guest_virtual_network_name
# }

# module "m3_testing" {
#   # Using m3_testing module to deploy TE-Agent
#   depends_on = [ module.m2_provision ]
#   source = "../../modules/m3_testing"

#   device_management_ip_address = var.device_management_ip_address

#   te_agent_token = var.te_agent_token
#   te_token = var.te_token
# }