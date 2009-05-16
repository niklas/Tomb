module Gibak
  Logger = ActiveSupport::BufferedLogger.new(STDERR)
  module Logging
    def logger
      Logger
    end
  end
end
