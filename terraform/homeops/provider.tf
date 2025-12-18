terraform {
  required_version = ">= 1.5.0"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 4.0.0"
    }
    authentik = {
      source  = "goauthentik/authentik"
      version = ">= 2024.0.0"
    }
  }

  cloud {
    hostname = "terra-api.gddnet.io"
    organization = "gdd"

    workspaces {
      name = "homeops"
    }
  }
}

provider "vault" {
  address = var.vault_addr
  token   = var.vault_token
}

provider "authentik" {
  url   = var.authentik_url
  token = var.authentik_token
}

