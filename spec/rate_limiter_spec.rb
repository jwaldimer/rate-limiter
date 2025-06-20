require_relative '../rate_limiter'
RSpec.describe RateLimiter do
  describe '#allow_request?' do
    it 'allows up to max_requests in the time window' do
      limiter = RateLimiter.new(30, 3)
      requests = [
        { timestamp: 1700000010, user_id: 1 },
        { timestamp: 1700000020, user_id: 1 },
        { timestamp: 1700000030, user_id: 1 },
        { timestamp: 1700000035, user_id: 1 }
      ]

      results = requests.map { |r| limiter.allow_request?(r[:timestamp], r[:user_id]) }
      expect(results).to eq([true, true, true, false])
    end

    it 'expires old requests after time_window' do
      limiter = RateLimiter.new(30, 3)
      requests = [
        { timestamp: 1700000010, user_id: 1 },
        { timestamp: 1700000020, user_id: 1 },
        { timestamp: 1700000030, user_id: 1 },
        { timestamp: 1700000041, user_id: 1 }
      ]

      results = requests.map { |r| limiter.allow_request?(r[:timestamp], r[:user_id]) }
      expect(results).to eq([true, true, true, true])
    end

    it 'handles multiple users independently' do
      limiter = RateLimiter.new(30, 2)
      requests = [
        { timestamp: 1700000010, user_id: 1 },
        { timestamp: 1700000012, user_id: 2 },
        { timestamp: 1700000020, user_id: 1 },
        { timestamp: 1700000025, user_id: 2 },
        { timestamp: 1700000031, user_id: 1 },
        { timestamp: 1700000033, user_id: 2 }
      ]

      results = requests.map { |r| limiter.allow_request?(r[:timestamp], r[:user_id]) }
      expect(results).to eq([true, true, true, true, false, false])
    end
  end
end
