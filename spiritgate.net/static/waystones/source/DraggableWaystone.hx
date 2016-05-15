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
class DraggableWaystone extends FlxSprite {
	var originX:Float;
	var originY:Float;
	var graphicPath:String;
	public var shape:String;
	var state:MainState;
	var standinBlock:FlxSprite;
	public var stone_properties:Array<String> = new Array<String>();
	public var name:String;
	public function new(X:Float=0, Y:Float=0, state:MainState, shape:String, stone_properties:Array<String>, name:String)  {
		super(X, Y);
		originX = X;
		originY = Y;
		this.shape = shape;
		graphicPath = "assets/images/" + shape + ".png";
		loadGraphic(graphicPath);
		origin.set(0, 0);
		scale.set(72.0 / frameWidth, 72.0 / frameHeight);
		updateHitbox(); 
		this.state = state;
		state.z1.add(this);
		this.name = name;
		
		this.stone_properties = stone_properties;
	}
	
	public function onMouseDown(block:FlxSprite) {
		if (state.sprite_following_mouse == null) {
			var standinBlock = new FlxSprite(block.x, block.y);
			standinBlock.loadGraphic(graphicPath);
			standinBlock.scale.set(72.0 / block.frameWidth, 72.0 / block.frameHeight);
			standinBlock.alpha = 0.5;
			standinBlock.origin.set(0, 0);
			state.add(standinBlock);
			this.standinBlock = standinBlock;
			
			state.z1.remove(block);
			state.z4.add(block);
			state.sprite_following_mouse = block;
			state.sprite_following_mouse.scale.set(1, 1);
			block.updateHitbox();
		}
	}
	public function onMouseUp(block:FlxSprite) {
		if (standinBlock != null) {
			var grid_x = Math.round(((block.x - FlxG.width + 512) / 128));
			var grid_y = Math.round(((block.y - FlxG.height + 512) / 128));
			var placedStone = new PlacedWaystone(grid_x * 128 + FlxG.width - 512, grid_y * 128 + FlxG.height - 512, state, shape, this.stone_properties, this.name);
			placedStone.angle = block.angle;
			placedStone.dirty = true;
			placedStone.updateHitbox();
			if (state.isValidPlacement(grid_x, grid_y, placedStone)) {
				state.place(placedStone);
			} else {
				state.z1.remove(placedStone);
			}
			block.angle = 0;
			
			state.z4.remove(block);
			state.z1.add(block);
			block.x = standinBlock.x;
			block.y = standinBlock.y;
			standinBlock.kill();
			block.scale.set(72.0 / block.frameWidth, 72.0 / block.frameHeight);
			block.updateHitbox();
			state.sprite_following_mouse = null;
		}
	}
}