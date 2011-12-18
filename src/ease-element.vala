using Clutter;
using Json;

public enum ElementType {
	TEXT,
	IMAGE
}

public abstract class Ease.Element {

	public ElementType type;

	public Element () {}
	public abstract Clutter.Actor render ();
	public abstract Json.Node json ();
	public abstract string to_string ();
}

