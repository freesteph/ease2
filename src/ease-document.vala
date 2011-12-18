using Gee;

public class Ease.Document {

	public string title { get; set; default = "Untitled presentation"; }

	private Gee.ArrayList<Ease.Slide> slides;

	public Document () {
		slides = new Gee.ArrayList<Ease.Slide> ();
	}

	public void add_slide () {
		var s = new Ease.Slide ();
		slides.add (s);
	}
}