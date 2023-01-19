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

resource "dnacenter_site" "subarea" {
  provider = dnacenter
  parameters {
    site {
      area {
        name = var.subarea_name
        parent_name = "${var.area_parent_name}/${var.area_name}"
      }
    }
  type = "area"
  }
}


resource "dnacenter_site" "building" {
  depends_on = [ dnacenter_site.subarea ]
  provider = dnacenter
  parameters {
    site {
      building {
        name = var.building_name
        parent_name = dnacenter_site.subarea.item.0.site_name_hierarchy
        address = var.building_address
      }
    }
  type = "building"
  }
}

resource "dnacenter_site" "floor" {
  depends_on = [ dnacenter_site.building ]
  provider = dnacenter
  parameters {
    site {
      floor {
        name = var.floor_name
        parent_name = dnacenter_site.building.item.0.site_name_hierarchy
        rf_model = var.floor_rf_model
        height = var.floor_height
        length = var.floor_length
        width = var.floor_width
      }
    }
  type = "floor"
  }
}
