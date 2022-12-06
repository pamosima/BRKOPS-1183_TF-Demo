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

data "dnacenter_sda_fabric_site" "default" {
  provider            = dnacenter
  site_name_hierarchy = "${var.area_parent_name}/${var.area_name}/${var.subarea_name}"
}

data "dnacenter_device_details" "fiab-1" {
  provider   = dnacenter
  identifier = "nwDeviceName"
  search_by  = "${var.device_hostname}.dna.cisco.com"
  timestamp = 1667833680000
}

resource "dnacenter_sda_provision_device" "fiab-1" {
  provider = dnacenter
  parameters {

    device_management_ip_address = data.dnacenter_device_details.fiab-1.item.0.management_ip_addr
    site_name_hierarchy          = "${var.area_parent_name}/${var.area_name}/${var.subarea_name}/${var.building_name}"
  }
}

resource "dnacenter_transit_peer_network" "ip-transit" {
  provider = dnacenter
  parameters {

    transit_peer_network_name = "${var.subarea_name}_Transit"
    transit_peer_network_type = "ip_transit"
    ip_transit_settings {
      autonomous_system_number = var.external_as_number
      routing_protocol_name ="BGP"
    }
  }
}

resource "dnacenter_sda_fabric_border_device" "fiab-1" {
  provider = dnacenter
  depends_on = [ dnacenter_sda_provision_device.fiab-1, dnacenter_transit_peer_network.ip-transit ]
  parameters {
    payload {
      device_management_ip_address       = data.dnacenter_device_details.fiab-1.item.0.management_ip_addr
      device_role                        = ["Border_Node", "Control_Plane_Node", "Edge_Node"]
      border_session_type                = "EXTERNAL"
      border_with_external_connectivity  = "true"
      connected_to_internet              = "false"
      external_connectivity_ip_pool_name = "${var.subarea_name}-Transit-Pool"
      external_connectivity_settings {
        external_autonomou_system_number = var.external_as_number
        interface_name                   = "TenGigabitEthernet1/1/1"
        interface_description            = "Uplink"
        l3_handoff {
            virtual_network {
              virtual_network_name = "INFRA_VN"
              vlan_id              = "3001"
            }
        }
        l3_handoff {
          virtual_network {
            virtual_network_name = var.vn_campus_virtual_network_name
            vlan_id              = "3002"
          }
        }
        l3_handoff {
          virtual_network {
            virtual_network_name = var.vn_guest_virtual_network_name
            vlan_id              = "3003"
          }
        }
      }   
      external_domain_routing_protocol_name = "BGP"
      internal_autonomou_system_number      = var.internal_as_number
      site_name_hierarchy                   = data.dnacenter_sda_fabric_site.default.item.0.site_name_hierarchy
    }
  }
}