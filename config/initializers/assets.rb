# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "fonts")

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( backend.js backend.css frontend.js frontend.css )

# include bower components in compiled assets
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'bower')

# tools
Rails.application.config.assets.precompile += %w( frontend/tools/hca_query.css )
Rails.application.config.assets.precompile += %w( frontend/tools/gia_certificate.css )