module Gibak
  #include Mount
  GibakDir = File.expand_path(File.dirname(__FILE__)) + '/../../vendor/lib/gibak'
  MountPoint = ENV['HOME'] + '/.git'
  class Base
    include Ignore
    include Logging
    attr_accessor :dir
    def initialize(dir = MountPoint)
      @dir = dir
    end
    # Initialises the gibak repos
    #   like: gitbak init
    def init!
      Logger.info("Initializing.. this can take a while.")
      run('init')
    end

    %w(changed new ignored newly-ignored).each do |filegroup|
      class_eval <<-EODEF
        def ls_#{filegroup.underscore}_files(&block)
          ls('#{filegroup}', &block)
        end
      EODEF
    end

    def exists?
      File.exists? @dir
    end

    def mount
      true # stub out sshfs mounting..
    end

    def unmount
      true # same as mount
    end

    def ls(what='changed')
      pipe("ls-#{what}-files") do |io|
        while line = io.gets
          yield line
        end
      end
    end

    private

    def run(action, *args)
      mount
      command = build_command(action, *args)
      Logger.debug("running #{command}")
      system(command)
    end

    def pipe(action, *args)
      mount
      command = build_command(action, *args)
      Logger.debug("reading from #{command}")
      open "|#{command}" do |io| 
        yield(io)
      end
    end

    # TODO consider #dir
    def build_command(action, *args)
      %Q~#{gibak_path} #{action} #{args.join(' ')}~
    end

    def gibak_path
      File.join(GibakDir, 'gibak')
    end
  end
end
