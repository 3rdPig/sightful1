Rails.application.config.middleware.use OmniAuth::Builder do
  config = Rails.application.config.x.settings["oauth2"]

  provider :google_oauth2, '877192536147-a1ackohkdnchehq369dcnoeckkh892mh.apps.googleusercontent.com',
                           'VFYYdpecEInfZUKSTyBhYIzz',
                           image_size: 150
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'],
           fields: ['id', 'email-address', 'first-name', 'last-name', 'headline',
                    'location', 'industry', 'picture-url', 'public-profile-url',
                    'positions'
           ]
end
