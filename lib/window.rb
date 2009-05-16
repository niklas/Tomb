module Tomb
  class Window
    attr_reader :filelist
    attr_reader :glade

    GladePath = File.expand_path(File.dirname(__FILE__)) + '/../config/tomb.glade'

    def initialize
      @glade = GladeXML.new(GladePath) {|handler| method(handler)}
    end

    def show!
      @glade["MainWindow"].show_all
      Gtk.main
    end

    def quit
      Gtk.main_quit
    end

    def on_quit_clicked
      quit
    end
  end

  class FileList
    attr_reader :store, :view, :gibak
    Path = 0
    def initialize
      @store = Gtk::ListStore.new(String)
      @store.set_default_sort_func {|a,b| a[Path] <=> b[Path] }
      @view = Gtk::TreeView.new(@store)
      setup_tree_view(@view)
      @gibak = Gibak::Base.new
    end

    def update
      store.clear
      gibak.ls_new_files do |path|
        iter = store.append
        store.set_value iter, Path, path
      end
    end

    def setup_tree_view(view)
      renderer = Gtk::CellRendererText.new
      column = Gtk::TreeViewColumn.new("Path", renderer, :text => Path)
      view.append_column(column)
      view
    end

    def destroy
      @gibak.unmount
    end
  end
end