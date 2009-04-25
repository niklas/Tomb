module Gibak
  class Build
    LibDir = $:.unshift(File.expand_path(File.dirname(__FILE__)) + '../../vendor/lib/gibak')
    def executables_exist?
      %w(find-git-files find-git-repos gibak ometastore).all? do |ex|
        File.executable? File.join(LibDir,ex)
      end
    end

    def build!
      system %Q~cd '#{LibDir}' && omake~
    end

    def build
      build! unless executables_exist?
    end
  end
end
