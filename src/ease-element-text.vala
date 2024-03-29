
public class Ease.TextElement : Ease.Element {

	public string text { get; set; default = "Text"; }
	public string font { get; set; default = "Sans"; }
	public int size { get; set; default = 32; }

	public TextElement () {
		this.type = ElementType.TEXT;
	}

	public TextElement.with_text (string text) {
		this.text = text;
	}

	public override Clutter.Actor render () {
		var a = new Clutter.Text.full (@"$(this.font) $(this.size)",
									   this.text,
									   Clutter.Color.from_string ("red"));
		return a;
	}

	public override Json.Node json () {
		var node = new Json.Node (Json.NodeType.OBJECT);
		var obj = new Json.Object ();
		// FIXME: this should be in the Element class with ElementType
		obj.set_string_member ("type", "text");
		obj.set_string_member ("text", this.text);
		obj.set_string_member ("font", this.font);
		obj.set_int_member ("size", this.size);
		node.set_object (obj);
		return node;
	}

	public override string to_string () {
		return @"text: \"$(this.text)\", $(this.font) $(this.size)";
	}
}