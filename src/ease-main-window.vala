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
		window.show_all ();
	}
}