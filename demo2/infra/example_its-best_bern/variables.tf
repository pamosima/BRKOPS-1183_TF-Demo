
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

variable "dnac_username" {}
variable "dnac_password" {}
variable "dnac_url" {}

variable "area_parent_name" {
  type = string
  default = "Global/Terraform/Demo2"
}

variable "area_name" {
  type = string
  default = "ITs-Best"
}

variable "subarea_name" {
  type = string
  default = "ITB_Bern"
}

variable "building_name" {
  type = string
  default = "BE-1"  
}

variable "building_address" {
  type = string
  default = "Morgenstrasse 129, 3018 Bern, Switzerland"  
}

variable "ip_pool_prefix" { 
  type = string
  default = "10.120."
}

variable "vn_campus_virtual_network_name" {
  type = string
  default = "ITB_Campus"
}

variable "vn_guest_virtual_network_name" {
  type = string
  default = "ITB_Guest"
}

variable "device_hostname" {
  type = string
  default = "be-fiab-1"
}

variable "device_management_ip_address" {
  type = string
  default = "10.120.1.1"
}

variable "p2p_onboarding_ip_address" {
  type = string
  default = "10.120.0.2"  
}
variable "p2p_onboarding_gw" {
  type = string
  default = "10.120.0.1"  
}

variable "device_pid" {
  type = string
  default = "C9300-48UXM"
}

variable "device_serial_number" {
  type = string
  default = "FCW2146L09N"  
}

variable  "external_as_number" { 
  type = number
  default = "65533"
}

variable  "internal_as_number" { 
  type = number
  default = "65532"
}

variable "p2p_onboarding_vlan" {
  type = number
  default = "30"
}

variable  "p2p_infra-vn_vlan" { 
  type = number
  default = "3011"
}

variable  "p2p_campus-vn_vlan" { 
  type = number
  default = "3012"
}

variable  "p2p_guest-vn_vlan" { 
  type = number
  default = "3013"
}

variable "uplink_interface_name" {
  type = string
  default = "TenGigabitEthernet1/0/48"   
}

variable "ios_xe_username" {
  type        = string
  description = "IOS-XE Username"
}

variable "ios_xe_password" {
  type        = string
  description = "IOS-XE Password"
}

variable "insecure" {
  type        = bool
  default     = true
  description = "IOS-XE HTTPS insecure"
}

variable "timeout" {
  type        = number
  default     = 120
  description = "IOS-XE Client timeout"
}

variable "te_agent_token" {}
variable "te_token" {}
