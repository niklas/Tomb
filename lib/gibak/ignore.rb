module Gibak
  module Ignore
    DirectoryRegexp    = %r~^(.*)/$~
    IncludeSlashRegexp = %r~/~

    def ignore_file
      File.dirname(dir) + '/.gitignore'
    end

    def ignore_path_with?(path, filter)
      return false if path.blank?
      case filter
      when nil
        false
      when DirectoryRegexp
        path.ends_with? filter
      when IncludeSlashRegexp
        File.fnmatch(filter, path, File::FNM_PATHNAME)
      else
        File.fnmatch(filter, File.basename(path), File::FNM_PATHNAME)
      end
    end
  end
end
