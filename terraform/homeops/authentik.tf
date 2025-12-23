resource "authentik_stage_prompt_field" "invite_email" {
  name        = "Invite Email"
  field_key   = "email"
  label       = "Email"
  type        = "email"
  required    = true
  placeholder = "user@company.tld"
  order       = 10
}

resource "authentik_stage_prompt_field" "invite_username" {
  name        = "Invite Username"
  field_key   = "username"
  label       = "Username"
  type        = "text"
  required    = true
  placeholder = "jdoe"
  order       = 20
}

resource "authentik_stage_prompt_field" "invite_name" {
  name        = "Invite Name"
  field_key   = "name"
  label       = "Full name"
  type        = "text"
  required    = false
  placeholder = "Jane Doe"
  order       = 30
}

resource "authentik_stage_invitation" "enrollment_invitation" {
  name = "Enrollment - Invitation"
  continue_flow_without_invitation = false
}

resource "authentik_stage_prompt" "enrollment_prompts" {
  name   = "Enrollment - Prompts"
  fields = [
    authentik_stage_prompt_field.invite_email.id,
    authentik_stage_prompt_field.invite_username.id,
    authentik_stage_prompt_field.invite_name.id,
  ]
}

resource "authentik_stage_password" "enrollment_password" {
  name = "Enrollment - Set Password"
  backends = ["authentik.core.auth.InbuiltBackend"]
}

resource "authentik_stage_user_write" "enrollment_user_write" {
  name = "Enrollment - Create/Update User"
  create_users_as_inactive = false
}

resource "authentik_flow" "invitation_enrollment_flow" {
  name        = "Invitation Enrollment"
  slug        = "invitation-enrollment"
  title       = "Accept invitation"
  designation = "enrollment"
}

resource "authentik_flow_stage_binding" "bind_invitation" {
  target = authentik_flow.invitation_enrollment_flow.id
  stage  = authentik_stage_invitation.enrollment_invitation.id
  order  = 10
}

resource "authentik_flow_stage_binding" "bind_prompts" {
  target = authentik_flow.invitation_enrollment_flow.id
  stage  = authentik_stage_prompt.enrollment_prompts.id
  order  = 20
}

resource "authentik_flow_stage_binding" "bind_password" {
  target = authentik_flow.invitation_enrollment_flow.id
  stage  = authentik_stage_password.enrollment_password.id
  order  = 30
}

resource "authentik_flow_stage_binding" "bind_user_write" {
  target = authentik_flow.invitation_enrollment_flow.id
  stage  = authentik_stage_user_write.enrollment_user_write.id
  order  = 40
}