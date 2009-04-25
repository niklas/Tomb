# On Debian/Ubuntu you need the following packages:
# omake git ocaml-nox
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
      %w(omake git bash).all? do |bin|
        check_for_executable_in_path(bin)
      end &&
        check_for_ocaml_dev
    end
    
    private
    def check_for_ocaml_dev
      check_for_executable_in_path('ocamlbuild', "Please install ocaml-nox")
    end
    def check_for_executable_in_path(name, message=nil)
      bin = `which #{name}`.chomp
      unless File.executable? bin
        self.errors << (message || "please install #{name}")
        false
      else
        true
      end
    end
  end
end
