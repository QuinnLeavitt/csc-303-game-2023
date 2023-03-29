package level;

import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import level.LevelGenerator;
import tank.TankFactory;

class PlayState extends FlxState {
	private static var TILE_HEIGHT(default, never):Int = 32;
	private static var TILE_WIDTH(default, never):Int = 32;

	private static var LEVEL_HEIGHT(default, never):Int = 32;
	private static var LEVEL_WIDTH(default, never):Int = 32;

	private var safeZoneY = 40;

	override public function create() {
		super.create();

		bgColor = FlxColor.WHITE;
		var gen = new LevelGenerator(20, 20);
		var bitmap = gen.generateLevel();
		var enemyBitmap = gen.placeEnemyTanks(bitmap);
		var playerBitmap = gen.placePlayerTank(bitmap);

		var map = new FlxTilemap();
		trace(bitmap);
		map.loadMapFrom2DArray(bitmap, AssetPaths.Wall__png, TILE_WIDTH, TILE_HEIGHT);
		placePlayerTank();

		add(map);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	public function placePlayerTank() {
		var playerTank = TankFactory.NewPlayerTank(250, 560);
		add(playerTank.getAllSprites());
	}
}
