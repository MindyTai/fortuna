Rails.application.config.generators do |g|
  g.test_framework :test_unit, fixture: false
  g.fixture_replacement :factory_girl, dir: 'spec/factories'
end
