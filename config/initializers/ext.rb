# frozen_string_literal: true

Dir[Rails.root.join('lib', 'ext', '**', '*.rb')].each { |f| require f }
