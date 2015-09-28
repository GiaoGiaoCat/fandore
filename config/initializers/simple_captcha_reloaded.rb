require 'simple_captcha_reloaded/adapters/simple_form'

SimpleCaptchaReloaded::Config.tap do |config|
  # config.captcha_path = '/simple_captcha'
  config.image = SimpleCaptchaReloaded::Image.new(
      # implode: :medium,
      # distortion: :medium,
      # image_styles: {custom: ['-fill darkblue', '-solarize 50', '-background black']},
      noise: 3,
      size: '100x30',
  )
  config.characters = %w[0 1 2 3 4 5 6 7 8 9]
  config.length = 6
end
