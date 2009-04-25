module Gibak
  IgnoreFile = ENV['HOME'] + '/.gitignore'
  class Ignore
    def initialize
      @file = IgnoreFile
    end
  end
end
