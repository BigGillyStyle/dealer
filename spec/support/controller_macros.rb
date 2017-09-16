module ControllerMacros
  # https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-3-and-4-%28and-RSpec%29
  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      admin = create :admin
      # sign_in :user, admin # sign_in(scope, resource)
      sign_in admin, scope: :user
    end
  end

  # https://github.com/plataformatec/devise/wiki/How-To:-Stub-authentication-in-controller-specs
  # def sign_in(user = double('user'))
  #   if user.nil?
  #     allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
  #     allow(controller).to receive(:current_user).and_return(nil)
  #   else
  #     allow(request.env['warden']).to receive(:authenticate!).and_return(user)
  #     allow(controller).to receive(:current_user).and_return(user)
  #   end
  # end
end
