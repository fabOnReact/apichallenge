module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  module Authentication
    def login_user
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryBot.create(:user)
        sign_in user
      end
    end
  end

  # https://www.jacopobeschi.com 
  # Solve problems gracefully with dynamic method generation in ruby
  module HttpHelpers
    %w(get delete).each do |m|
      class_eval "def #{m}_authorized(uri, user); #{m} uri, params: nil, headers: {'X-User-Email' => user.email, 'X-User-Token' => user.authentication_token}; end"
    end

    %w(post patch put).each do |m|
      class_eval "def #{m}_authorized(uri, data, user, headers = {}); #{m} uri,params: data, headers: headers.merge({'X-User-Email' => user.email, 'X-User-Token' => user.authentication_token}); end"
    end 
  end
end
