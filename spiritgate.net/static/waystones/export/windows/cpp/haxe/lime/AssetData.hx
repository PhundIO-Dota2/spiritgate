package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/data/data-goes-here.txt", "assets/data/data-goes-here.txt");
			type.set ("assets/data/data-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/1x1.png", "assets/images/1x1.png");
			type.set ("assets/images/1x1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/1x1triangle.png", "assets/images/1x1triangle.png");
			type.set ("assets/images/1x1triangle.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/1x2.png", "assets/images/1x2.png");
			type.set ("assets/images/1x2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/1x2doubletriangle.png", "assets/images/1x2doubletriangle.png");
			type.set ("assets/images/1x2doubletriangle.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/1x2triangle.png", "assets/images/1x2triangle.png");
			type.set ("assets/images/1x2triangle.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/2x2.png", "assets/images/2x2.png");
			type.set ("assets/images/2x2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/2x2triangle.png", "assets/images/2x2triangle.png");
			type.set ("assets/images/2x2triangle.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/3x2arch.png", "assets/images/3x2arch.png");
			type.set ("assets/images/3x2arch.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/3x2L.png", "assets/images/3x2L.png");
			type.set ("assets/images/3x2L.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/3x2R.png", "assets/images/3x2R.png");
			type.set ("assets/images/3x2R.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/4x4duelist.png", "assets/images/4x4duelist.png");
			type.set ("assets/images/4x4duelist.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/button.png", "assets/images/button.png");
			type.set ("assets/images/button.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/grid.png", "assets/images/grid.png");
			type.set ("assets/images/grid.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/images-go-here.txt", "assets/images/images-go-here.txt");
			type.set ("assets/images/images-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/mouse_point.png", "assets/images/mouse_point.png");
			type.set ("assets/images/mouse_point.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/ScrollBar.png", "assets/images/ScrollBar.png");
			type.set ("assets/images/ScrollBar.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/sidepanel.png", "assets/images/sidepanel.png");
			type.set ("assets/images/sidepanel.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tooltip.png", "assets/images/tooltip.png");
			type.set ("assets/images/tooltip.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/toparea.png", "assets/images/toparea.png");
			type.set ("assets/images/toparea.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/music/music-goes-here.txt", "assets/music/music-goes-here.txt");
			type.set ("assets/music/music-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/sounds-go-here.txt", "assets/sounds/sounds-go-here.txt");
			type.set ("assets/sounds/sounds-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/beep.ogg", "assets/sounds/beep.ogg");
			type.set ("assets/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/flixel.ogg", "assets/sounds/flixel.ogg");
			type.set ("assets/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/fonts/nokiafc22.ttf", "assets/fonts/nokiafc22.ttf");
			type.set ("assets/fonts/nokiafc22.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("assets/fonts/arial.ttf", "assets/fonts/arial.ttf");
			type.set ("assets/fonts/arial.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
