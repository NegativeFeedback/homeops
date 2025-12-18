resource "vault_mount" "kms" {
  path = "kms"
  type = "transit"
}

