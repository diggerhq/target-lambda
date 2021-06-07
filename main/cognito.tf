

resource "aws_cognito_user_pool" "cognito_user_pool" {
  name = "${var.project_name}-${var.environment}"

  password_policy {
    minimum_length = 6
    require_lowercase = false
    require_uppercase = false
    require_digits = false
    require_symbols = false
    temporary_password_validity_days = 30
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 1      
    }
  }

  alias_attributes = ["username_attributes"]

  admin_create_user_config {
    invite_message_template {
      email_subject = "Invite to join Bewell Digital!"
      email_message = "Hello {username}, you have been invited to join our Bewell Digital app! Your temporary password is {####}"
      sms_message   = "Hello {username}, Your temporary password for our Bewell Digital app is {####}"
    }
  }
}

