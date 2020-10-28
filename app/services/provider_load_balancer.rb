class ProviderLoadBalancer
  def self.call
    new.call
  end

  def call
    # currently load balanced based on randomness. extracted here beause the
    # docs suggest we would want to build out more robust load balancing logic

    rand < 0.7 ? primary_provider : secondary_provider
  end

  private

  def primary_provider
    Provider.find_by(name: 'Provider 2')
  end

  def secondary_provider
    Provider.find_by(name: 'Provider 1')
  end
end