module Tomb
  class Window < Gtk::Window
    attr_reader :filelist

    def initialize
      super(Gtk::Window::TOPLEVEL)
      self.resizable = true
      self.title = "Tomb"
      self.border_width = 10
      self.signal_connect('delete_event') { quit }
      self.set_size_request(275, -1)
      create_layout
    end

    def create_layout
      vbox = Gtk::VBox.new(false, 5)
      vbox.pack_start create_toolbar, false
      vbox.pack_start create_search_field, false
      vbox.pack_start_defaults create_filelist
      add vbox
    end

    def create_toolbar
      toolbar = Gtk::Toolbar.new
      toolbar.show_arrow = true
      toolbar.toolbar_style = Gtk::Toolbar::Style::BOTH

      buttons = []
      buttons << refresh = Gtk::ToolButton.new( Gtk::Stock::REFRESH)
      buttons << apply   = Gtk::ToolButton.new( Gtk::Stock::APPLY)
      buttons << Gtk::SeparatorToolItem.new
      buttons << quit    = Gtk::ToolButton.new( Gtk::Stock::QUIT)

      refresh.signal_connect('clicked') { self.filelist.update }
      quit.signal_connect('clicked')    { self.quit }

      buttons.each_with_index do |button, i|
        toolbar.insert(i, button)
      end
      toolbar
    end

    def create_search_field
      field = Gtk::Entry.new
      field
    end

    def create_filelist
      @filelist = FileList.new
      scrolled = Gtk::ScrolledWindow.new
      scrolled.add @filelist.view
      scrolled.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
      scrolled
    end

    def show!
      show_all
      Gtk.main
    end

    def quit
      Gtk.main_quit
    end
  end

  class FileList
    attr_reader :store, :view, :gibak
    Path = 0
    def initialize
      @store = Gtk::ListStore.new(String)
      @store.set_default_sort_func {|a,b| a[Path] <=> b[Path] }
      @view = Gtk::TreeView.new
      setup_tree_view(@view)
      @gibak = Gibak::Base.new
      @view.model = @store
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
  end
end
