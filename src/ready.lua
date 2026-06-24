local shopRoomMap = {
    F = "F_PreBoss01",
    G = "G_PreBoss01",
    H = "H_PreBoss01",
    I = "I_PreBoss01",

    N = "N_PreBoss01",
    O = "O_PreBoss01",
    P = "P_PreBoss01",
    Q = "Q_PreBoss01",
}

game.StoreData.BossRushWorldShop =
{
    GroupsOf =
    {
        {
            WeightedList = true,
            Offers = 1,
            OptionsData =
            {
                { Name = "RandomLoot", Weight = 5 },
            },
        },
        {
            WeightedList = true,
            Offers = 1,
            OptionsData =
            {
                { Name = "MaxHealthDrop" },
                { Name = "StackUpgrade", Cost = 100, ReplaceRequirements = { NamedRequirements = { "StackUpgradeLegal" }, } },
            },
        },
        {
            WeightedList = true,
            Offers = 1,
            OptionsData =
            {
                { Name = "MaxManaDrop", },
                {
                    Name = "TalentDrop",
                    Weight = 0.7,
                    ReplaceRequirements =
                    {
                        NamedRequirements = { "TalentLegal", },
                        {
                            Path = { "CurrentRun", "EnteredBiomes" },
                            Comparison = ">",
                            Value = 1,
                        },
                        {
                            PathFalse = { "CurrentRun", "BiomeUseRecord", "TalentDrop" },
                        },
                    },
                },
            },
        },
    }
}

modutil.mod.Path.Wrap("ChooseStartingRoom", function (base, currentRun, args)
    if currentRun[_PLUGIN.guid .. "BossRush"] and shopRoomMap[args.StartingBiome] and game.RoomData[shopRoomMap[args.StartingBiome]] then
        local roomData = game.CreateRoom(game.RoomData[shopRoomMap[args.StartingBiome]], args)
        if not game.Contains({"Q", "I"}) then
            roomData.StoreDataName = "BossRushWorldShop"
        end
        roomData.Starting = true
        roomData.RemoveTimerBlock = "InterBiome"
        roomData.BiomeStartRoom = true
        return roomData
    end
    return base(currentRun, args)
end)

modutil.mod.Path.Wrap("StartNewRun", function (base, ...)
    local currentRun = base(...)
    if not config.dream_dive_only or currentRun.IsDreamRun then
        currentRun[_PLUGIN.guid .. "BossRush"] = true
        game.AddResource( "Money", 1000, "RunStart" )
        game.AddTrait( game.CurrentRun.Hero, "RestockBoon", "Epic")
    end
    return currentRun
end)

modutil.mod.Path.Wrap("RemoveStoreItem", function (base, args)
    if not (game.CurrentRun == nil or game.CurrentRun.CurrentRoom == nil or game.CurrentRun.CurrentRoom.Store == nil) and game.CurrentRun[_PLUGIN.guid .. "BossRush"] then
        table.insert(game.CurrentRun.CurrentRoom.Store.StoreOptions, {Name = args.Name})
    end
    if game.CurrentRun == nil or game.CurrentRun.CurrentRoom == nil or game.CurrentRun.CurrentRoom.Store == nil or game.IsEmpty( game.CurrentRun.CurrentRoom.Store.StoreOptions ) then
		return
	end
    local value = base(args)
    if game.CurrentRun[_PLUGIN.guid .. "BossRush"] then
        game.CurrentRun.CurrentRoom.FirstPurchase = nil
    end
    return value
end)

modutil.mod.Path.Wrap("RestockWorldItem", function (base, replacedIndex, kitId, args)
    if game.CurrentRun[_PLUGIN.guid .. "BossRush"] then
        args.Name = _PLUGIN.guid .. "InvalidName"
    end
    local spawnedStoreItemsCopy = game.ShallowCopyTable(game.CurrentRun.CurrentRoom.Store.SpawnedStoreItems)

    base(replacedIndex, kitId, args)

    for key, value in pairs(game.CurrentRun.CurrentRoom.Store.SpawnedStoreItems) do
        if not spawnedStoreItemsCopy[key] then
            game.CurrentRun.CurrentRoom.Store.SpawnedStoreItems[replacedIndex] = value
            if key ~= replacedIndex then
                game.CurrentRun.CurrentRoom.Store.SpawnedStoreItems[key] = nil
            end
            break
        end
    end
end)