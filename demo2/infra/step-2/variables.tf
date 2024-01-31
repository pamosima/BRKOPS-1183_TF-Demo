
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
}

variable "area_name" {
  type = string
}

variable "subarea_name" {
  type = string
}

variable "building_name" {
  type = string 
}

variable "building_address" {
  type = string
}

variable "site_id" {
  type = string
}

variable "device_hostname" {
  type = string
}

variable "device_pid" {
  type = string
}

variable "device_serial_number" {
  type = string
}

variable  "external_as_number" { 
  type = number
}

variable  "internal_as_number" { 
  type = number
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

variable "ip_pools" {
  type = list(map(string))
  default = [
    { 
        name = "Transit-Pool"
        subnet_id = "16"
        type = "Generic"
    },
    { 
        name = "LAN-Auto-Pool"
        subnet_id = "17"
        type = "LAN"
    },
    { 
        name = "User-Pool"
        subnet_id = "18"
        type = "Generic"
    },
    { 
        name = "Guest-Pool"
        subnet_id = "19"
        type = "Generic"
    },
    { 
        name = "AP-Pool"
        subnet_id = "20"
        type = "Generic"
    },
    { 
        name = "EX-Pool"
        subnet_id = "21"
        type = "Generic"
    }
  ]
}
