module Gibak
  class Build
    LibDir = File.expand_path(File.dirname(__FILE__)) + '/../../vendor/lib/gibak'
    def self.executables_exist?
      %w(find-git-files find-git-repos gibak ometastore).all? do |ex|
        File.executable? File.join(LibDir,ex)
      end
    end

    def self.build!
      system %Q~cd '#{LibDir}' && omake~
    end

    def self.build
      unless Dependencies.met?
        raise "missing dependencies: #{Dependencies.errors.join(', ')}"
      end
      build! unless executables_exist?
    end
  end
end
