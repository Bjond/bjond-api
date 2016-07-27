class InitializerGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)

  def create_initializer_file
    copy_file "initializer.rb",  "config/initializers/bjond_api_initializer.rb"
  end
end