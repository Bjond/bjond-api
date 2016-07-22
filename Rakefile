require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('bjond-integration-gem', '0.1.0') do |p|
  p.description    = "Helper that facilitates communication with Bjönd servers."
  p.url            = "http://github.com/Bjond/bjond-integration-gem"
  p.author         = "Blake Rego"
  p.email          = "blake.rego@bjondinc.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }