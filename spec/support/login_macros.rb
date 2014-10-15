module LoginMacros
  
  def stub_env_for_omniauth
    env = { "omniauth.auth" => OmniAuth.config.mock_auth[:twitter] }
    @controller.stub!(:env).and_return(env)
  end

end
  