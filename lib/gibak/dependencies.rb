module Gibak
  class Dependencies
    include Singleton
    attr_accessor :errors
    def self.met?
      instance.met?
    end

    def self.errors
      instance.errors
    end

    def met?
      self.errors = []
      %w(omake).all? do |dep|
        self.send "check_for_#{dep}"
      end
    end
    
    private
    def check_for_omake
      check_for_executable_in_path('omake')
    end

    def check_for_executable_in_path(name)
      bin = `which #{name}`.chomp
      unless File.executable? bin
        self.errors << "please install #{name}"
        false
      else
        true
      end
    end
  end
end
