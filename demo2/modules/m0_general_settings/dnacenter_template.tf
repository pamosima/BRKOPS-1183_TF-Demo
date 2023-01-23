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

data "dnacenter_projects_details" "onboarding" {
  provider   = dnacenter
  name       = "Onboarding Configuration"
  limit = "1"
}

resource "dnacenter_configuration_template" "fiab" {
  provider = dnacenter
  parameters {
    name         = "FiAB_Onboarding-Template"
    version = "2.0"
    project_id   = data.dnacenter_projects_details.onboarding.items.0.id
    software_type    = "IOS"
    software_version = "17.6.1"
    device_types {
      product_family = "Switches and Hubs"
    }
    template_content = "hostname $HOSTNAME\n!\nip routing\n!\nno ip domain lookup\n!\nsystem mtu 9100\nlicense boot level network-advantage addon dna-advantage\nlicense smart reservation\n!\ninterface Loopback0\n description Fabric Underlay RID - do not change\n ip address $MANAGEMENT_IP_ADDRESS 255.255.255.255\n!\n!\nip route 192.168.99.0 255.255.255.0 $P2P_ONBOARDING_GW 240\n!\nip http client source-interface Loopback0\nip http client connection forceclose\n\nip ssh server algorithm mac hmac-sha1\n!\nnetconf-yang\nrestconf\n!\nevent manager applet UplinkPort\n event timer countdown time 120\n action a1010 cli command \"enable\"\n action b1010 cli command \"conf t\"\n action c1010 cli command \"default interface vlan 1\"\n action d1010 cli command \"vlan $P2P_ONBOARDING_VLAN\"\n action d1015 cli command \"name p2p_onboarding\"\n action d1017 cli command \"exit\"\n action d1020 cli command \"interface vlan $P2P_ONBOARDING_VLAN\"\n action d1030 cli command \"ip address $P2P_ONBOARDING_IP_ADDRESS 255.255.255.252\"\n action d1040 cli command \"exit\"\n action d1050 cli command \"interface $UPLINK_INTERFACE_NAME\"\n action d1055 cli command \"description Uplink\"\n action d1060 cli command \"switchport mode trunk\"\n action d1070 cli command \"switchport trunk native vlan $P2P_ONBOARDING_VLAN\"\n action d1080 cli command \"exit\"\n action e1010 cli command \"no event manager applet UplinkPort\"\nexit\n\n"
    template_params {
        data_type        = "STRING"
        display_name     = "Hostname"
        instruction_text = "Enter a Hostname for the PnP Switch"
        not_param        = "false"
        order            = 1
        parameter_name   = "HOSTNAME"
        required = "true"
    }
        template_params {
        data_type        = "STRING"
        display_name     = "Management IP-Address"
        instruction_text = "Enter a Management IP-Address for the PnP Switch"
        not_param        = "false"
        order            = 2
        parameter_name   = "MANAGEMENT_IP_ADDRESS"
        required = "true"
    }
    template_params {
        data_type        = "STRING"
        display_name     = "P2P Onboarding IP-Adress"
        instruction_text = "Enter a P2P Onbaording IP-Address for the PnP Switch"
        not_param        = "false"
        order            = 3
        parameter_name   = "P2P_ONBOARDING_IP_ADDRESS"
        required = "true"
    }
        template_params {
        data_type        = "STRING"
        display_name     = "P2P Onboarding Gateway IP-Address"
        instruction_text = "Enter a P2P Onboarding Gateway IP-Address for the PnP Switch"
        not_param        = "false"
        order            = 4
        parameter_name   = "P2P_ONBOARDING_GW"
        required = "true"
    }    
    template_params {
        data_type        = "STRING"
        display_name     = "Uplink Interface Name"
        instruction_text = "Enter a Uplink Interface Name for the PnP Switch"
        not_param        = "false"
        order            = 5
        parameter_name   = "UPLINK_INTERFACE_NAME"
        required = "true"
    }
        template_params {
        data_type        = "STRING"
        display_name     = "P2P Onboarding VLAN"
        instruction_text = "Enter a P2P Onboarding VLAN for the PnP Switch"
        not_param        = "false"
        order            = 6
        parameter_name   = "P2P_ONBOARDING_VLAN"
        required = "true"
    }        
  }
}