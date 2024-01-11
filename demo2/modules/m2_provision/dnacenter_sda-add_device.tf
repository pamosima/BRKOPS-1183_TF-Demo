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

data "external" "inventory_state" {
  program = ["python3", "dnac_inventory-state.py"]

  query = {
    ip_address = "172.31.${var.site_id}.1"
  }
}
data "dnacenter_network_device_list" "device" {
  provider           = dnacenter
  hostname           = ["${var.device_hostname}.*"]
}
data "dnacenter_sda_fabric_site" "default" {
  provider            = dnacenter
  site_name_hierarchy = "${var.area_parent_name}/${var.area_name}/${var.subarea_name}"
}

resource "dnacenter_sda_provision_device" "fiab-1" {
  depends_on = [ data.external.inventory_state ]
  provider = dnacenter
  parameters {

    device_management_ip_address = "172.31.${var.site_id}.1"
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
      device_management_ip_address       = "172.31.${var.site_id}.1"
      device_role                        = ["Border_Node", "Control_Plane_Node", "Edge_Node"]
      border_session_type                = "EXTERNAL"
      border_with_external_connectivity  = "true"
      connected_to_internet              = "false"
      external_connectivity_ip_pool_name = "${var.subarea_name}-Transit-Pool"
      external_connectivity_settings {
        external_autonomou_system_number = var.external_as_number
        interface_name                   = var.uplink_interface_name
        interface_description            = "Uplink"
        l3_handoff {
            virtual_network {
              virtual_network_name = "INFRA_VN"
              vlan_id              = var.p2p_infra-vn_vlan
            }
        }
        l3_handoff {
          virtual_network {
            virtual_network_name = var.vn_campus_virtual_network_name
            vlan_id              = var.p2p_campus-vn_vlan
          }
        }
        l3_handoff {
          virtual_network {
            virtual_network_name = var.vn_guest_virtual_network_name
            vlan_id              = var.p2p_guest-vn_vlan
          }
        }
      }   
      external_domain_routing_protocol_name = "BGP"
      internal_autonomou_system_number      = var.internal_as_number
      site_name_hierarchy                   = data.dnacenter_sda_fabric_site.default.item.0.site_name_hierarchy
    }
  }
}