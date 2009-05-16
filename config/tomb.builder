<?xml version="1.0"?>
<interface>
  <requires lib="gtk+" version="2.16"/>
  <!-- interface-naming-policy project-wide -->
  <object class="GtkListStore" id="files">
    <columns>
      <!-- column-name Path -->
      <column type="guchar"/>
    </columns>
    <data>
      <row>
        <col id="0"/>
      </row>
    </data>
  </object>
  <object class="GtkWindow" id="MainWindow">
    <child>
      <object class="GtkVBox" id="vbox1">
        <property name="visible">True</property>
        <property name="orientation">vertical</property>
        <child>
          <object class="GtkToolbar" id="Toolbar">
            <property name="visible">True</property>
            <property name="toolbar_style">both</property>
            <child>
              <object class="GtkToolButton" id="Quit">
                <property name="visible">True</property>
                <property name="label" translatable="yes">Quit</property>
                <property name="use_underline">True</property>
                <property name="stock_id">gtk-quit</property>
                <signal name="clicked" handler="on_quit_clicked"/>
              </object>
              <packing>
                <property name="expand">False</property>
                <property name="homogeneous">True</property>
              </packing>
            </child>
          </object>
          <packing>
            <property name="expand">False</property>
            <property name="fill">False</property>
            <property name="position">0</property>
          </packing>
        </child>
        <child>
          <object class="GtkHBox" id="hbox1">
            <property name="visible">True</property>
            <child>
              <object class="GtkLabel" id="FilterLabel">
                <property name="visible">True</property>
                <property name="label" translatable="yes">Filter</property>
              </object>
              <packing>
                <property name="expand">False</property>
                <property name="position">0</property>
              </packing>
            </child>
            <child>
              <object class="GtkEntry" id="Filter">
                <property name="visible">True</property>
                <property name="can_focus">True</property>
                <property name="invisible_char">&#x25CF;</property>
              </object>
              <packing>
                <property name="position">1</property>
              </packing>
            </child>
            <child>
              <object class="GtkButton" id="GoButton">
                <property name="visible">True</property>
                <property name="can_focus">True</property>
                <property name="receives_default">True</property>
              </object>
              <packing>
                <property name="expand">False</property>
                <property name="position">2</property>
              </packing>
            </child>
          </object>
          <packing>
            <property name="expand">False</property>
            <property name="position">1</property>
          </packing>
        </child>
        <child>
          <object class="GtkScrolledWindow" id="scrolledwindow1">
            <property name="visible">True</property>
            <property name="can_focus">True</property>
            <property name="hscrollbar_policy">automatic</property>
            <property name="vscrollbar_policy">automatic</property>
            <child>
              <object class="GtkTreeView" id="FilesView">
                <property name="visible">True</property>
                <property name="can_focus">True</property>
                <property name="model">files</property>
                <property name="search_column">0</property>
              </object>
            </child>
          </object>
          <packing>
            <property name="position">2</property>
          </packing>
        </child>
      </object>
    </child>
  </object>
</interface>
