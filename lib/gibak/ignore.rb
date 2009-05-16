module Gibak
  module Ignore
    def ignore_file
      File.dirname(dir) + '/.gitignore'
    end
  end
end
