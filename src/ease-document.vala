using Gee;
using Json;

public class Ease.Document {

	public string title { get; set; default = "Untitled presentation"; }
	public string uri { get; set; default = ""; }
	public int current_slide;

	private Gee.ArrayList<Ease.Slide> slides;

	public Document () {
		slides = new Gee.ArrayList<Ease.Slide> ();
		current_slide  = -1;
	}

	public Document.from_uri (string uri) {
		this ();
		var parser = new Json.Parser ();
		try {
			parser.load_from_file (uri);
		} catch (Error e) {
			error ("Could not load presentation: " + e.message);
		}
		var root = parser.get_root ();
		var root_obj = root.get_object ();

		this.title = root_obj.get_string_member ("title");
		var slides_array = root_obj.get_array_member ("slides");
		slides_array.foreach_element ((array, index, node) =>
			{
				this.add_slide ();
				var slide = this.slides.get (current_slide);
				var elements_array = node.get_array ();
				elements_array.foreach_element ((arr, ind, nod) =>
					{
						var e = nod.get_object ();
						switch (e.get_string_member ("type")) {
						case "text":
							debug ("size: %i", (int)e.get_int_member ("size"));
							slide.add_text_element (e.get_string_member ("text"),
													e.get_string_member ("font"),
													(int)e.get_int_member ("size"));
							break;
						case "image":
							break;
						case "video":
							break;
						default:
							break;
						}
					});
			});
	}

	public void add_slide () {
		var s = new Ease.Slide ();
		slides.add (s);
		current_slide = slides.index_of (s);
	}

	public Ease.Slide get_current_slide () {
		return slides.get (current_slide);
	}

	public bool save () {
		if (this.uri == "") {
			warning ("Cannot save presentation without a filename");
			return false;
		}

		var writer = new Json.Generator ();
		writer.set_pretty (true);

		var root = new Json.Node (Json.NodeType.OBJECT);
		var r = new Json.Object ();
		root.set_object (r);

		/* title */
		var title_node = new Json.Node (Json.NodeType.VALUE);
		title_node.set_string (this.title);
		r.set_member ("title", title_node);

		/* slides */
		var slides_array  = new Json.Array ();
		foreach (Ease.Slide s in this.slides) {
			var slide_node = s.json ();
			slides_array.add_element (slide_node);
		}

		r.set_array_member ("slides", slides_array);
		writer.set_root (root);
		try {
			writer.to_file (uri);
		} catch (Error e) {
			error ("Could not write presentation to file: " + e.message);
		}

		return true;
	}

	public string to_string () {
		var res = "Document name: " + this.title;
		for (int i = 0; i < slides.size; i++) {
			res += @"\n\tSlide n°$(i+1): " + slides.get(i).to_string ();
		}
		return res;
	}
}
