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

    def on_filter_changed(entry)
      filelist.filter_string = entry.text
    end
  end

  class FileList
    attr_reader :store, :view, :gibak
    attr_reader :filtered_store, :filter_string
    Path = 0
    def initialize(container)
      setup_store
      setup_tree_view
      container.add view
      @gibak = Gibak::Base.new
    end

    def update
      store.clear
      gibak.ls_new_files do |path|
        iter = store.append
        store.set_value iter, Path, path.chomp
      end
    end

    def filter_string=(new_filter_string)
      @filter_string = new_filter_string
      filtered_store.refilter
    end

    def setup_tree_view
      @view = Gtk::TreeView.new(filtered_store)
      renderer = Gtk::CellRendererText.new
      column = Gtk::TreeViewColumn.new("Path", renderer, :text => Path)
      view.append_column(column)
      view
    end

    def setup_store
      @store          = Gtk::ListStore.new(String)
      @filtered_store = Gtk::TreeModelFilter.new(store)

      store.set_default_sort_func {|a,b| a[Path] <=> b[Path] }

      @filter_string = ''
      filtered_store.set_visible_func do |model, iter|
        path_visible? iter[Path]
      end
    end

    def path_visible?(path)
      filter_string.blank? || path.include?(filter_string)
    end

    def destroy
      gibak.unmount
    end
  end
end
