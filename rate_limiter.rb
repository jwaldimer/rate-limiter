class RateLimiter
  def initialize(time_window, max_requests)
    @time_window = time_window
    @max_requests = max_requests
    @requests = Hash.new { |hash, key| hash[key] = [] }
  end

  def allow_request?(timestamp, user_id)
    queue = @requests[user_id]
    time_diff = timestamp - @time_window

    queue.shift while !queue.empty? && queue.first <= time_diff

    return false unless queue.size < @max_requests

    queue << timestamp
    true
  end
end
