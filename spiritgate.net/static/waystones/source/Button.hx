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
class Button extends FlxSprite {
	var state:MainState;
	var onClick:Void->Void;
	var onClickCooldown = 0;
	public function new(X:Float=0, Y:Float=0, state:MainState, text:String, onClick:Void->Void)   {
		super(X, Y);
		
		this.state = state;
		loadGraphic("assets/images/button.png", true, 130, 40);
		animation.add("default", [0]);
		animation.add("hover", [1]);
		animation.add("pressed", [2]);
		state.z2.add(this);
		animation.play("default", true);
		var flxtext = new FlxText(X + 2.5, Y + 2.5, 125, text, 20);
		flxtext.alignment = "center";
		state.z2.add(flxtext);
		
		this.onClick = onClick;
	}
	override public function update() {
		animation.play("default", true);
		if (FlxCollision.pixelPerfectCheck(state.mouse_collider_sprite, this)) {
			if ( FlxG.mouse.justPressed) { 
				animation.play("pressed", true);
				onClickCooldown = 4;
				onClick();
			}
			else if(onClickCooldown == 0) {
				animation.play("hover", true);
			}
		}
		if (onClickCooldown > 0) {
			onClickCooldown--;
		}
	}
}