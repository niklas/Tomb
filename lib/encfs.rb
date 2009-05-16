class EncFS
  attr_reader :mountpoint, :root, :name
  def initialize(mountpoint, root, name="EncFS")
    @mountpoint = mountpoint
    @root = root
    @name = name
  end

  # TODO et name
  def mount
    system %Q(encfs #{absolute_root} #{absolute_mountpoint})
  end

  def umount
    system %Q(fusermount -u #{absolute_mountpoint})
  end

  def absolute_mountpoint
    File.expand_path mountpoint
  end

  def absolute_root
    File.expand_path root
  end
end
