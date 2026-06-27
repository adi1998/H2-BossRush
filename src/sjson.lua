local gameplayFile = rom.path.combine(rom.paths.Content(), "Game\\Obstacles\\Gameplay.sjson")

local obstacleTemplate =
{
		Name = "DummyBoon",
		InheritFrom = "BaseBoon",
		DisplayInEditor = true,
		MagnetismSpeedMax = 0,
		MagnetismSpeedMin = 0,
		MagnetismWhileBlocked = 0,
		MaxMagnetismZ = 0,
		MaxCollisionZ = 160,
		Thing =
		{
			EditorOutlineDrawBounds = false,
			Graphic = "BoonDropOlympus",
			OffsetZ = 160,
		}
	}

sjson.hook(gameplayFile, function (data)
    for lootName, _ in pairs(mod.newLootData) do
        local newLootObstacle = game.DeepCopyTable(obstacleTemplate)
        newLootObstacle.Name = lootName
        table.insert(data.Obstacles, newLootObstacle)
    end
    return data
end)