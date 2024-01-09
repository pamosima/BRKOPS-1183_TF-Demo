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

resource "dnacenter_area" "area" {
  provider = dnacenter
  parameters {
    site {
      area {
        name        = var.area_name
        parent_name = var.area_parent_name
      }
    }
  type = "area"
  }
}

resource "dnacenter_area" "subarea" {
  depends_on  = [ dnacenter_area.area ]
  provider    = dnacenter
  parameters {
    site {
      area {
        name        = var.subarea_name
        parent_name = "${var.area_parent_name}/${var.area_name}"
      }
    }
  type = "area"
  }
}


resource "dnacenter_building" "building" {
  depends_on  = [ dnacenter_area.subarea ]
  provider    = dnacenter
  parameters {
    site {
      building {
        name        = var.building_name
        parent_name = dnacenter_area.subarea.item.0.site_name_hierarchy
        address     = var.building_address
      }
    }
  type = "building"
  }
}