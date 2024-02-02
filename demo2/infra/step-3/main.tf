
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

data "external" "pyats_job" {
  program = ["python", "pyats_job.py","${var.testbed}"]
}

output "pyats_job" {
  value = data.external.pyats_job.result.exit_code 
}

resource "null_resource" "dummy" {
  count = data.external.pyats_job.result.exit_code == "0" ? 1 : 0

  provisioner "local-exec" {
    command = "echo 'pyATS Job Successfull! Continue with additional resources.'"
  }
} 