require 'test_helper'

class ProviderLoadBalancerTest < ActiveSupport::TestCase
  describe '.call' do
    before do
      ProviderLoadBalancer.any_instance.stubs(:primary_provider).returns(:primary)
      ProviderLoadBalancer.any_instance.stubs(:secondary_provider).returns(:secondary)
    end

    # hard to test randomness
    it 'returns the primary provider more often than the secondary provider' do
      sample = 300.times.map do
        ProviderLoadBalancer.call
      end

      assert sample.count(:primary) > sample.count(:secondary)
    end
  end
end