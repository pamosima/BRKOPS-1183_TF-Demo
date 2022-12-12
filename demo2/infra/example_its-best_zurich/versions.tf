terraform {
  required_providers {
    dnacenter = {
      source = "cisco-en-programmability/dnacenter"
      version = "1.0.14-beta"
    }
    ciscoapphosting = {
      source  = "robertcsapo/ciscoapphosting"
      version = "1.0.0"
    }
    thousandeyes = {
      source  = "thousandeyes/thousandeyes"
      version = "1.0.0-beta"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.8.0"
    }
  }
}