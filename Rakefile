begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
    gem.name = "bjond-api"
    gem.summary = "Interface that facilitates communication with Bjönd servers."
    gem.description = "Rails engine that provides communication between Bjönd Server Core and a client app."
    gem.email = "blake.rego@bjondinc.com"
    gem.homepage = "http://github.com/Bjond/bjond-integration-gem"
    gem.authors = ["Blake Rego"]
    gem.add_dependency 'faraday', '~> 0.9.2'
    gem.add_dependency 'syruppay_jose', '~> 1.0'
    gem.add_dependency 'attr_encrypted', '~> 3.0', '>= 3.0.3'
    # gem.add_dependency 'less-rails', '~> 2.7', '>= 2.7.1'
    # gem.add_dependency 'less', '~> 2.6'
    gem.licenses = ['GPL']
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available.  Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end