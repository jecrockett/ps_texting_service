require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  describe 'Message validity' do
    it 'is valid with a recipient and content' do
      assert build(:message, recipient:'1231231234', content: 'This is some content').valid?
    end

    it 'is invalid without a recipient' do
      refute build(:message, recipient: nil, content: 'This is some content').valid?
    end

    it 'is invalid without content' do
      refute build(:message, recipient:'1231231234', content: nil).valid?
    end
  end
end
