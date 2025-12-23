variable "vault_addr" {
  type        = string
  description = "Vault API address, e.g. https://vault.example.com:8200"
}

variable "vault_token" {
  type        = string
  description = "Vault root/admin token for bootstrap (store securely)"
  sensitive   = true
}

variable "authentik_url" {
  type        = string
  description = "Authentik base URL, e.g. https://auth.example.com"
}

variable "authentik_token" {
  type        = string
  description = "Authentik API token"
  sensitive   = true
}

variable "oidc_client_name" {
  type        = string
  default     = "vault"
  description = "Display name for the Authentik application/provider"
}

variable "vault_oidc_mount_path" {
  type        = string
  default     = "oidc"
  description = "Vault auth mount path for OIDC, e.g. oidc"
}

variable "vault_redirect_uris" {
  type        = list(string)
  description = "OIDC redirect URIs for Vault UI/CLI callback"
  # examples:
  # [
  #   "https://vault.example.com/ui/vault/auth/oidc/oidc/callback",
  #   "http://localhost:8250/oidc/callback"
  # ]
}

variable "vault_default_role" {
  type        = string
  default     = "default"
}

# Map Authentik group names (as emitted in token claim) to Vault policy sets.
variable "group_policy_map" {
  type = map(object({
    policies = list(string)
  }))
  default = {
    "vault-admins" = { policies = ["vault-admin"] }
    "vault-readonly" = { policies = ["vault-readonly"] }
  }
}

# Claim names
variable "groups_claim" {
  type    = string
  default = "groups"
}

variable "user_claim" {
  type    = string
  default = "email"
}

variable "sl_domain" {
  description = "The domain that should activate this tenant/brand (e.g., sl.securitylab.io)."
  type        = string
}

variable "sl_title" {
  description = "Branding title shown in UI (tab title, headers)."
  type        = string
  default     = "SecurityLab"
}

variable "flow_background_url" {
  description = "Optional background image URL for flows (can also be set per-flow). Leave blank to skip."
  type        = string
  default     = ""
}

variable "default_locale" {
  description = "Default locale for the tenant/brand."
  type        = string
  default     = "en-us"
}