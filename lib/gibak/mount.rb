module Gibak
  MountPoint = ENV['HOME'] + '/.git'
  Options = %w(auto_cache )
  class Mount
    def self.mount
      mount! unless mounted?
    end

    def self.mount!
      FileUtils.mkdir_p MountPoint
      Logger.info("mounting #{MountPoint}")
      system(%Q~sshfs cinema:/media/home/niklas/wigowyr_gibak #{MountPoint}~)
    end

    def self.mounted?
      File.exists? File.join(MountPoint, 'HEAD')
    end

    def self.umount
      umount! if mounted?
    end

    def self.umount!
      Logger.info("umounting #{MountPoint}")
      system(%Q~fusermount -u #{MountPoint}~)
    end
  end
end
