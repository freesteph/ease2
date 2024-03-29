using Clutter;
using GtkClutter;
using Gtk;

public class Ease.MainWindow {

	private Gtk.Window window;
	private Gtk.Box main_vbox;
	private Gtk.Builder builder;
	private Clutter.Stage stage;
	private Ease.Document document;

	public MainWindow () {
		builder = new Gtk.Builder ();
		try {
			builder.add_from_file ("ease-main-window.ui");
		} catch (Error e) {
			error ("Could not load UI file: " + e.message);
		}

		window = builder.get_object ("main_window") as Gtk.Window;
		main_vbox = builder.get_object ("main_vbox") as Gtk.Box;

		builder.connect_signals (this);

		this.window.delete_event.connect ( () =>
			{
				Gtk.main_quit ();
				return true;
			});
		/* styling stuff */
		var settings = Gtk.Settings.get_default ();
		settings.set ("gtk-application-prefer-dark-theme", true);
		var toolbar = builder.get_object ("file_tools") as Gtk.Toolbar;
		var context = toolbar.get_style_context ();
		context.add_class ("primary-toolbar");

		/* set up the stage */
		var embed = new GtkClutter.Embed ();
		main_vbox.pack_end (embed);
		stage = embed.get_stage () as Clutter.Stage;
		stage.color = { 42, 42, 42, 255 };
	}

	public void run () {
		document = new Ease.Document ();
		document.add_slide ();
		var s = document.get_current_slide ();

		this.stage.add (s.render ());
		this.stage.show_all ();
		window.show_all ();
	}

	[CCode (instance_pos = -1)]
	public void open_cb (Gtk.ToolButton button) {
		var open_dialog = builder.get_object ("open_dialog") as Gtk.FileChooserDialog;
		if (open_dialog.run () == Gtk.ResponseType.ACCEPT) {
			Document d;
			try {
				d = new Document.from_uri (open_dialog.get_filename ());
				this.load_document (d);
			} catch (Error e) {
				var message = "<b>Oops, this does not appear to be" +
					" a valid presentation file.</b>\n" +
					"\nThis could be either because your file is badly " +
					"formatted or because the developers need to get better at " +
					"programming. Apologies\n" +
					"\nTry with another file.";
				var err_dialog = new Gtk.MessageDialog (this.window,
														Gtk.DialogFlags.MODAL,
														Gtk.MessageType.ERROR,
														Gtk.ButtonsType.OK,
														"");
				err_dialog.set_markup (message);
				err_dialog.run ();
				err_dialog.destroy ();
				open_cb (button);
			}
		}
		open_dialog.destroy ();
	}

	[CCode (instance_pos = -1)]
	public void save_cb (Gtk.ToolButton button) {
		if (this.document.uri != "") {
			this.document.save ();
		} else {
			var save_dialog = builder.get_object ("save_dialog") as Gtk.FileChooserDialog;
			if (save_dialog.run () == Gtk.ResponseType.ACCEPT) {
				this.document.uri = save_dialog.get_filename ();
				this.document.save ();
			}
			save_dialog.destroy ();
		}
	}

	[CCode (instance_pos = -1)]
	public void save_as_cb (Gtk.ToolButton button) {
		var save_dialog = builder.get_object ("save_dialog") as Gtk.FileChooserDialog;
		if (save_dialog.run () == Gtk.ResponseType.ACCEPT) {
			this.document.uri = save_dialog.get_filename ();
			this.document.save ();
		}
		save_dialog.destroy ();
	}

	public void refresh () {
		this.stage.remove_all ();
		var s = document.get_current_slide ();

		this.stage.add (s.render ());
		this.stage.show_all ();
		this.window.title = "Ease presentation editor: " + this.document.title;
	}

	public void load_document (Document d) {
		this.document = d;
		refresh ();
	}
}