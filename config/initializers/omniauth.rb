Rails.application.config.middleware.use OmniAuth::Builder do
    #provider :identity, :fields => [:name, :email]
    #provider :github, Rails.application.secrets.github_provider_key, Rails.application.secrets.github_provider_secret
end
