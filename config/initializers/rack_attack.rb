class Rack::Attack
  self.cache.store = ActiveSupport::Cache::MemoryStore.new

  safelist('allow-localhost') do |req|
    ['127.0.0.1', '::1'].include?(req.ip)
  end

  throttle('npcs/generate/ip', limit: 5, period: 60.seconds) do |req|
    req.ip if req.path.start_with?('/npcs/generate') && req.post?
  end

  self.throttled_responder = lambda do |request|
    [
      429,
      { 'Content-Type' => 'application/json' },
      [{ error: 'Too Many Requests', message: 'You have hit the rate limit for NPC generation' }.to_json]
    ]
  end
end
