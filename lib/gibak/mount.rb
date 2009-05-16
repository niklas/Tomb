module Gibak
  Options = %w(auto_cache )
  module Mount
    def mount
      mount! unless mounted?
    end

    def mount!
      FileUtils.mkdir_p dir
      Logger.info("mounting #{dir}")
      system(%Q~sshfs cinema:/media/home/niklas/wigowyr_gibak #{dir}~)
    end

    def mounted?
      exists?
    end

    def umount
      umount! if mounted?
    end

    def umount!
      Logger.info("umounting #{dir}")
      system(%Q~fusermount -u #{dir}~)
    end
  end
end
