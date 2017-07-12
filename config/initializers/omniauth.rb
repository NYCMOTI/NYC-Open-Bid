Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.full_host = lambda do |env|
    scheme = env['rack.url_scheme']
    local_host = env['HTTP_HOST']
    forwarded_host = env['HTTP_X_FORWARDED_HOST']
    forwarded_host.blank? ? ENV["ROOT_URL"] : ENV["ROOT_URL"]
  end
  provider(
    :github,
    GithubCredentials.client_id,
    GithubCredentials.secret,
    scope: "user:email"
  )
end
