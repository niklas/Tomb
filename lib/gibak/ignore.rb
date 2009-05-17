module Gibak
  module Ignore
    def ignore_file
      File.dirname(dir) + '/.gitignore'
    end

    def ignore_path_with?(path, filter)
      return false if path.blank?
      case filter
      when nil
        false
      when %r~^(.*)/$~     # directories
        path.ends_with? filter
      when %r~/~           # shell glob agains path
        File.fnmatch(filter, path, File::FNM_PATHNAME)
      else                 # shell glob agains filename
        File.fnmatch(filter, File.basename(path), File::FNM_PATHNAME)
      end
    end
  end
end
