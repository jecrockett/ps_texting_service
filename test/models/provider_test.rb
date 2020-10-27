require 'test_helper'

class ProviderTest < ActiveSupport::TestCase
  describe 'Provider validity' do
    it 'is valid with a name and url' do
      assert build(:provider, name:'Provider X', url: 'http://thisisanendpoint.com/test').valid?
    end

    it 'is invalid without a name' do
      refute build(:provider, name: nil, url: 'http://thisisanendpoint.com/test').valid?
    end

    it 'is invalid without a url' do
      refute build(:provider, name:'1231231234', url: nil).valid?
    end
  end
end
