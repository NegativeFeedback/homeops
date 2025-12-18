resource "vault_mount" "kms" {
  path = "kms"
  type = "transit"
}

resource "vault_transit_secret_backend_key" "tofu_state" {
  backend = vault_mount.kms.path
  name    = "tofu_state"
  type               = "aes256-gcm96"
  deletion_allowed   = false
  exportable         = false
}
