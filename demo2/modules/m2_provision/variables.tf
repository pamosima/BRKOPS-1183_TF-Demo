
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


variable "area_parent_name" {}
variable "area_name" {}
variable "subarea_name" {}
variable "building_name" {}

variable "site_id" {}
variable "device_hostname" {}

variable "vn_campus_virtual_network_name" {}
variable "vn_guest_virtual_network_name" {}
variable "external_as_number" {}
variable "internal_as_number" {}
variable "p2p_infra-vn_vlan" {}
variable "p2p_campus-vn_vlan" {}
variable "p2p_guest-vn_vlan" {}
variable "uplink_interface_name" {}
