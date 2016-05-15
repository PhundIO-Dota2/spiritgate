package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.plugin.MouseEventManager;
import flixel.util.FlxPoint;
import flixel.util.FlxCollision;
import haxe.Http;
import haxe.Json;

/**
 * ...
 * @author Gavin Gassmann
 */
class PlacedWaystone extends FlxSprite {
	var state:MainState;
	public var stone_properties:Array<String>;
	public var name:String;
	public var shape:String;
	
	public function new(X:Float=0, Y:Float=0, state:MainState, shape:String, stone_properties:Array<String>, name:String)  {
		super(X, Y);
		this.state = state;
		this.shape = shape;
		loadGraphic("assets/images/" + shape + ".png");
		state.z1.add(this);
		this.stone_properties = stone_properties;
		this.name = name;
	}

	public function onMouseDown(block:PlacedWaystone) {
		if (state.sprite_following_mouse == null) {
			state.z1.remove(block);
			state.z4.add(block);
			state.sprite_following_mouse = block;
			state.sprite_following_mouse.scale.set(1, 1);
			block.updateHitbox();
			state.waystones.remove(block);
		}
	}
	public function onMouseUp(block:PlacedWaystone) {
		var grid_x = Math.round(((block.x - FlxG.width + 512) / 128));
		var grid_y = Math.round(((block.y - FlxG.height + 512) / 128));
		
		block.x = grid_x * 128 + FlxG.width - 512;
		block.y = grid_y * 128 + FlxG.height - 512;
		
		if (state.isValidPlacement(grid_x, grid_y, block)) {
			state.place(block);
			state.z4.remove(block);
			state.z1.add(block);
		} else {
			state.z1.remove(block);
			block.kill();
		}
		state.sprite_following_mouse = null;
	}
}