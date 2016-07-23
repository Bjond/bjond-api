
module BjondIntegration

  def register_app(bjondhost=ENV['BJOND_SERVER'])
    url = bjondhost + '/server-core/services/integrationmanager/register'
  end

end