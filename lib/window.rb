module Tomb
  class Window < Gtk::Window
    def initialize
      super(Gtk::Window::TOPLEVEL)
      self.resizable = true
      self.title = "Tomb"
      self.border_width = 10
      self.signal_connect('delete_event') { quit }
      self.set_size_request(275, 300)
      create_layout
    end

    def create_layout
      vbox = Gtk::VBox.new(false, 5)
      vbox.pack_start_defaults create_toolbar
      add vbox
    end

    def create_toolbar
      toolbar = Gtk::Toolbar.new
      toolbar.show_arrow = true
      toolbar.toolbar_style = Gtk::Toolbar::Style::BOTH

      button = Gtk::ToolButton.new( Gtk::Stock::COPY )

      toolbar.insert(0, button)
      toolbar
    end

    def show!
      show_all
      Gtk.main
    end

    def quit
      Gtk.main_quit
    end
  end
end
