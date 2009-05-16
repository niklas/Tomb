module Tomb
  class Window
    attr_reader :filelist
    attr_reader :glade
    attr_reader :scroller

    GladePath = File.expand_path(File.dirname(__FILE__)) + '/../config/tomb.glade'

    def initialize
      @glade = GladeXML.new(GladePath) {|handler| method(handler)}
      @scroller = @glade['List']
      @filelist = FileList.new scroller
    end

    def show!
      @glade["MainWindow"].show_all
      Gtk.main
    end

    def gtk_main_quit
      Gtk.main_quit
    end

    def on_quit_clicked
      filelist.destroy
      gtk_main_quit
    end

    def on_refresh_clicked
      filelist.update
    end
  end

  class FileList
    attr_reader :store, :view, :gibak
    Path = 0
    def initialize(container)
      @store = Gtk::ListStore.new(String)
      @store.set_default_sort_func {|a,b| a[Path] <=> b[Path] }
      @view = Gtk::TreeView.new(@store)
      container.add view
      setup_tree_view
      @gibak = Gibak::Base.new
    end

    def update
      store.clear
      gibak.ls_new_files do |path|
        iter = store.append
        store.set_value iter, Path, path
      end
    end

    def setup_tree_view
      renderer = Gtk::CellRendererText.new
      column = Gtk::TreeViewColumn.new("Path", renderer, :text => Path)
      view.append_column(column)
      view
    end

    def destroy
      gibak.unmount
    end
  end
end
