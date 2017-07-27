module Cgc
  class Engine < ::Rails::Engine
    isolate_namespace Cgc

    initializer :assets do |app|
      config.assets.paths << Rails.root.join('assets', 'fonts', 'cgc')
      config.assets.paths << Rails.root.join('assets', 'images', 'cgc')
      config.assets.precompile << %w(vendor/assets/*)
      app.config.assets.precompile << %w( *.png *.jpg *.gif )
    end
  end
end
