package;

import flixel.FlxGame;
import level.PlayState;
import level.TestGenState;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();
		addChild(new FlxGame(640, 640, PlayState));
	}
}
