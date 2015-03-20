Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '388309278018403', '204786e658ace882d1af27faf7d79124'
end

