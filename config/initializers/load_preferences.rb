APP_CONFIG = YAML::load(File.open("#{RAILS_ROOT}/config/tension_preferences.yml"))
#APP_CONFIG = YAML::load(ERB.new(IO.read(File.join(RAILS_ROOT, 'config', 'tension_preferences.yml'))).result)[RAILS_ENV]
