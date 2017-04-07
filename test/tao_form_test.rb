require 'test_helper'

class TaoFormTest < ActiveSupport::TestCase

  test 'version number' do
    assert TaoForm::VERSION.is_a? String
  end

  test 'TaoForm::Engine inherits from Rails::Engine' do
    assert TaoForm::Engine < Rails::Engine
  end

end
