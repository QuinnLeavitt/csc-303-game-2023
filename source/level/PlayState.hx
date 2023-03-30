package level;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import level.LevelGenerator;
import tank.Tank;
import tank.TankFactory;

class PlayState extends FlxState {
	private static var TILE_HEIGHT(default, never):Int = 32;
	private static var TILE_WIDTH(default, never):Int = 32;

	private static var LEVEL_HEIGHT(default, never):Int = 20;
	private static var LEVEL_WIDTH(default, never):Int = 20;

	private var safeZoneY = 40;
	private var map:FlxTilemap;

	private var playerTank:Tank;
	private var enemyTanks:FlxTypedGroup<Tank>;

	override public function create() {
		super.create();

		bgColor = FlxColor.WHITE;
		var bitmap = LevelGenerator.generateLevel(LEVEL_HEIGHT, LEVEL_WIDTH);
		trace(bitmap);
		map = new FlxTilemap();
		map.loadMapFrom2DArray(bitmap, AssetPaths.Wall__png, TILE_WIDTH, TILE_HEIGHT);
		trace(bitmap);
		LevelGenerator.placeEnemyTanks(bitmap, LEVEL_HEIGHT, LEVEL_WIDTH);
		trace(bitmap);
		LevelGenerator.placePlayerTank(bitmap, LEVEL_HEIGHT, LEVEL_WIDTH);
		trace(bitmap);
		placePlayerTank();

		add(map);
		addTanks();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		FlxG.collide(playerTank, map);
		FlxG.collide(enemyTanks, map);
		FlxG.collide(playerTank, enemyTanks);
		FlxG.collide(enemyTanks, enemyTanks);
	}

	private function addTanks() {
		var tankCoordinates = [200, 300, 400];
		enemyTanks = new FlxTypedGroup<Tank>(3);
		for (x in tankCoordinates) {
			var enemy = TankFactory.NewDumbTank(x, 50);
			enemyTanks.add(enemy);
		}
		for (enemyTank in enemyTanks) {
			add(enemyTank.getAllSprites());
		}
	}

	public function placePlayerTank() {
		playerTank = TankFactory.NewPlayerTank(250, 550);
		add(playerTank.getAllSprites());
	}
}
