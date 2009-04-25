module Gibak
  GibakDir = File.expand_path(File.dirname(__FILE__)) + '/../../vendor/lib/gibak'
  class Base
    # Initialises the gibak repos
    #   like: gitbak init
    def init
      Logger.info("Initializing.. this can take a while.")
      run('init')
    end

    %w(changed new ignored newly-ignored).each do |filegroup|
      class_eval <<-EODEF
        def ls_#{filegroup.underscore}_files(&block)
          ls('#{filegroup}-files', &block)
        end
      EODEF
    end

    private

    def ls(what='changed-files')
      pipe("ls-#{what}") do |io|
        while line = io.gets
          yield line
        end
      end
    end

    def run(action, *args)
      Mount.mount
      command = build_command(action, *args)
      Logger.debug("running #{command}")
      system(command)
    end

    def pipe(action, *args)
      Mount.mount
      command = build_command(action, *args)
      Logger.debug("reading from #{command}")
      open "|#{command}" do |io| 
        yield(io)
      end
    end

    def build_command(action, *args)
      %Q~#{gibak_path} #{action} #{args.join(' ')}~
    end

    def gibak_path
      File.join(GibakDir, 'gibak')
    end
  end
end
