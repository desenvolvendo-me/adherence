# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

Rails.application.config.assets.configure do |env|
  env.cache = ActiveSupport::Cache.lookup_store(:memory_store) if Rails.env.development?
end

# Adiciona os diretórios ao path de assets
Rails.application.config.assets.paths << Rails.root.join("app/javascript")