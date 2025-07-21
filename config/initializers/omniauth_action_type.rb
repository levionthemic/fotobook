OmniAuth.config.before_request_phase do |env|
  req = Rack::Request.new(env)
  action_type = req.params['action_type']
  req.session['oauth_action_type'] = action_type if action_type.present?
end
