require 'test_helper'

class ProviderTest < ActiveSupport::TestCase
  describe 'Provider validity' do
    it 'is valid with a name and url' do
      assert Provider.new(name:'Provider X', url: 'http://thisisanendpoint.com/test').valid?
    end

    it 'is invalid without a name' do
      refute Provider.new(name: nil, url: 'http://thisisanendpoint.com/test').valid?
    end

    it 'is invalid without a url' do
      refute Provider.new(name:'1231231234', url: nil).valid?
    end
  end
end
