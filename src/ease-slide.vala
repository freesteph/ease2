using Json;

public class Ease.Slide {

	private Gee.ArrayList<Ease.Element> elements;
	public Clutter.Group actor { get; private set; }

	public Slide () {
		elements = new Gee.ArrayList<Ease.Element> ();
		actor = new Clutter.Group ();
	}


	public void add_text_element (string text, string font, int size) {
		var t = new TextElement ();
		t.text = text;
		t.font = font;
		t.size = size;

		this.elements.add (t);
	}

	public Clutter.Group render () {
		actor.remove_all ();
		foreach (Ease.Element e in elements) {
			actor.add (e.render ());
		}
		actor.show_all ();
		return actor;
	}

	public Json.Node json () {
		var node = new Json.Node (Json.NodeType.ARRAY);
		var elements_array = new Json.Array ();
		foreach (Ease.Element e in elements) {
				elements_array.add_element (e.json ());
		}
		node.set_array (elements_array);
		return node;
	}

	public string to_string () {
		var res = "";
		foreach (Ease.Element e in elements) {
			res += "\n\t" + e.to_string ();
		}
		return res;
	}
}