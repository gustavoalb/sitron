# -*- encoding : utf-8 -*-
class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
        user.password = Rails.application.secrets.admin_password
        user.cpf = Rails.application.secrets.admin_cpf
        user.password_confirmation = Rails.application.secrets.admin_password
        user.admin!
      end
  end
end
