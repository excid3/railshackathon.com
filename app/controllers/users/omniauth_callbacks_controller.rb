module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    before_action :set_service, except: [:failure]
    before_action :set_user, except: [:failure]

    attr_reader :service, :user

    def failure
      redirect_to root_path, alert: "Something went wrong"
    end

    def facebook
      handle_auth "Facebook"
    end

    def twitter
      handle_auth "Twitter"
    end

    def github
      handle_auth "Github"
    end

    private

    def handle_auth(kind)
      if service.present?
        service.update(Service.attributes_from_omniauth(auth))
      else
        user.services.create(Service.attributes_from_omniauth(auth))
      end

      if user_signed_in?
        flash[:notice] = "Your #{kind} account was connected."
        redirect_to edit_user_registration_path
      else
        # Redirect back to invitation
        if request.env['omniauth.origin'].include? "/invitations/"
          store_location_for(:user, request.env['omniauth.origin'])
        end

        sign_in_and_redirect user, event: :authentication
        set_flash_message :notice, :success, kind: kind
      end
    end

    def auth
      request.env['omniauth.auth']
    end

    def set_service
      @service = Service.where(provider: auth.provider, uid: auth.uid).first
    end

    def set_user
      if user_signed_in?
        @user = current_user
      elsif service.present?
        @user = service.user
      elsif user = User.find_by(email: auth.info.email)
        @user = user
      else
        @user = create_user
      end
    end

    def create_user
      User.create(
        email: auth.info.email,
        name: auth.info.name,
        password: Devise.friendly_token[0,20]
      )
    end
  end
end
