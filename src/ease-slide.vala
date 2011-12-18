
public class Ease.Slide {

	private Gee.ArrayList<Ease.Element> elements;
	public Clutter.Group actor { get; private set; }

	public Slide () {
		elements = new Gee.ArrayList<Ease.Element> ();
	}


	private void render () {
		foreach (Ease.Element e in elements) {
			actor.add (e.render ());
		}
	}
}