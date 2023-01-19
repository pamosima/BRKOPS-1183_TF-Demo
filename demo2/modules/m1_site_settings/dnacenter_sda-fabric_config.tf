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


resource "dnacenter_sda_fabric_site" "default" {
  depends_on = [ dnacenter_site.subarea ]
  provider = dnacenter
  parameters {

    fabric_name         = "${var.subarea_name}"
    site_name_hierarchy = "${var.area_parent_name}/${var.area_name}/${var.subarea_name}"
  }
}

data "dnacenter_sda_fabric_site" "default" {
  depends_on = [ dnacenter_sda_fabric_site.default ]
  provider            = dnacenter
  site_name_hierarchy = "${var.area_parent_name}/${var.area_name}/${var.subarea_name}"
}

resource "dnacenter_sda_fabric_authentication_profile" "default" {
  depends_on = [ dnacenter_sda_fabric_site.default ]
  provider = dnacenter
  parameters {
    payload {
      authenticate_template_name    = var.authenticate_template_name
      site_name_hierarchy           = data.dnacenter_sda_fabric_site.default.item.0.site_name_hierarchy
    }
  }
}

resource "dnacenter_sda_virtual_network" "infra_vn" {
  provider = dnacenter
  depends_on = [ dnacenter_sda_fabric_authentication_profile.default ]
  parameters {
    payload {
      site_name_hierarchy  = data.dnacenter_sda_fabric_site.default.item.0.site_name_hierarchy
      virtual_network_name = "INFRA_VN"
    }
  }
}

resource "dnacenter_sda_virtual_network" "vn_campus" {
  provider = dnacenter
  depends_on = [ dnacenter_sda_fabric_authentication_profile.default, dnacenter_sda_virtual_network.infra_vn ]
  parameters {
    payload {
      site_name_hierarchy  = data.dnacenter_sda_fabric_site.default.item.0.site_name_hierarchy
      virtual_network_name = var.vn_campus_virtual_network_name
    }
  }
}

resource "dnacenter_sda_virtual_network" "vn_guest" {
  provider = dnacenter
  depends_on = [ dnacenter_sda_fabric_authentication_profile.default, dnacenter_sda_virtual_network.infra_vn, dnacenter_sda_virtual_network.vn_campus ]
  parameters {
    payload {
      site_name_hierarchy  = data.dnacenter_sda_fabric_site.default.item.0.site_name_hierarchy
      virtual_network_name = var.vn_guest_virtual_network_name
    }
  }
}

resource "dnacenter_sda_virtual_network_ip_pool" "ap-pool" {
  provider = dnacenter
  depends_on = [ dnacenter_sda_virtual_network.infra_vn, dnacenter_sda_virtual_network.vn_campus, dnacenter_sda_virtual_network.vn_guest ]
  parameters {

    auto_generate_vlan_name  = "false"
    ip_pool_name             = "${var.subarea_name}-AP-Pool"
    is_common_pool           = "false"
    is_ip_directed_broadcast = "false"
    is_l2_flooding_enabled   = "false"
    is_layer2_only           = "false"
    is_this_critical_pool    = "false"
    is_wireless_pool         = "false"
    site_name_hierarchy      = data.dnacenter_sda_fabric_site.default.item.0.site_name_hierarchy
    traffic_type             = "Data"
    pool_type                = "AP"
    virtual_network_name     = "INFRA_VN"
    vlan_name                = "${var.subarea_name}-AP"
    vlan_id                  = "1023"
  }
}

resource "dnacenter_sda_virtual_network_ip_pool" "campus-pool" {
  provider = dnacenter
  depends_on = [ dnacenter_sda_virtual_network.infra_vn, dnacenter_sda_virtual_network.vn_campus, dnacenter_sda_virtual_network.vn_guest, dnacenter_sda_virtual_network_ip_pool.ap-pool ]
  parameters {

    auto_generate_vlan_name  = "false"
    ip_pool_name             = "${var.subarea_name}-Campus-Pool"
    is_common_pool           = "false"
    is_ip_directed_broadcast = "false"
    is_l2_flooding_enabled   = "false"
    is_layer2_only           = "false"
    is_this_critical_pool    = "false"
    is_wireless_pool         = "false"
    site_name_hierarchy      = data.dnacenter_sda_fabric_site.default.item.0.site_name_hierarchy
    traffic_type             = "Data"
    virtual_network_name     = var.vn_campus_virtual_network_name
    vlan_name                = "${var.subarea_name}-Campus"
    vlan_id                  = "1021"
  }
}

resource "dnacenter_sda_virtual_network_ip_pool" "guest-pool" {
  provider = dnacenter
  depends_on = [ dnacenter_sda_virtual_network.infra_vn, dnacenter_sda_virtual_network.vn_campus, dnacenter_sda_virtual_network.vn_guest, dnacenter_sda_virtual_network_ip_pool.ap-pool, dnacenter_sda_virtual_network_ip_pool.campus-pool ]
  parameters {

    auto_generate_vlan_name  = "false"
    ip_pool_name             = "${var.subarea_name}-Guest-Pool"
    is_common_pool           = "false"
    is_ip_directed_broadcast = "false"
    is_l2_flooding_enabled   = "false"
    is_layer2_only           = "false"
    is_this_critical_pool    = "false"
    is_wireless_pool         = "false"
    site_name_hierarchy      = data.dnacenter_sda_fabric_site.default.item.0.site_name_hierarchy
    traffic_type             = "Data"
    virtual_network_name     = var.vn_guest_virtual_network_name
    vlan_name                = "${var.subarea_name}-Guest"
    vlan_id                  = "1022"
  }
}
