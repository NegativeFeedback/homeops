data "authentik_flow" "provider_authorization" {
  slug = "default-provider-authorization-implicit-consent"
}
data "authentik_flow" "provider_invalidation" {
  slug = "default-provider-invalidation-flow"
}

resource "authentik_application" "pgadmin" {
  name              = "pgAdmin"
  slug              = "pgadmin"
  protocol_provider = authentik_provider_oauth2.pgadmin.id
}
resource "authentik_provider_oauth2" "pgadmin" {
  name      = "pgadmin"
  client_id = "pgadmin"
  authorization_flow = data.authentik_flow.provider_authorization.id
  invalidation_flow  = data.authentik_flow.provider_invalidation.id
  allowed_redirect_uris = [
    {
      matching_mode = "strict",
      url           = "https://pgadmin.int.gddnet.io/callback",
    }
  ]
}

resource "authentik_group" "pgadmin" {
  name         = "pgadmin"
}


