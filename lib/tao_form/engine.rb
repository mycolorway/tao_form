require 'simple_form'
require 'tao_on_rails'
require 'tao_form/inputs'
require 'tao_form/components'

module TaoForm
  class Engine < Rails::Engine
    
    paths['app/views'] << 'lib/views'

  end
end
