using Clutter;
using GtkClutter;
using Gtk;

public static void main (string []args) {
	GtkClutter.init (ref args);

	var win = new Ease.MainWindow ();
	win.run ();

	Gtk.main ();
}