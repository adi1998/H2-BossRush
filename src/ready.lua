local shopRoomMap = {
    F = "F_PreBoss01",
    G = "G_PreBoss01",
    H = "H_PreBoss01",
    I = "I_PreBoss01",

    N = "N_PreBoss01",
    O = "O_PreBoss01",
    P = "P_PreBoss01",
    Q = "Q_PreBoss01",

    Tartarus = "A_PreBoss01",
    Asphodel = "X_PreBoss01",
    Elysium = "Y_PreBoss01",
    Styx = "D_Intro",
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
                {
                    Name = "WeaponUpgradeDrop", Weight = 2.5,
                    ReplaceRequirements =
                    {
                        {
                            PathFalse = { "CurrentRun", "HubRewardLookup", "WeaponUpgrade" },
                        },
                        {
                            PathTrue = { "GameState", "UseRecord", "WeaponUpgrade" },
                        },
                        NamedRequirements = { "HammerLootRequirements" },
                    },
                },
                {
                    Name = "WeaponUpgradeDrop", Weight = 2.5,
                    ReplaceRequirements =
                    {
                        {
                            PathTrue = { "GameState", "UseRecord", "WeaponUpgrade" },
                        },
                        NamedRequirements = { "LateHammerLootRequirements" },
                    },
                },
                {
                    Name = "WeaponUpgradeDrop", Weight = 2.5,
                    ReplaceRequirements =
                    {
                        {
                            PathTrue = { "GameState", "UseRecord", "WeaponUpgrade" },
                        },
                        {
                            Path = { "CurrentRun", "EnteredBiomes" },
                            Comparison = ">",
                            Value = 4,
                        },
                        NamedRequirements = { DDT_guid.."LateHammerLootRequirements" },
                    },
                },
                {
                    Name = "WeaponUpgradeDrop", Weight = 2.5,
                    ReplaceRequirements =
                    {
                        {
                            PathTrue = { "GameState", "UseRecord", "WeaponUpgrade" },
                        },
                        {
                            Path = { "CurrentRun", "EnteredBiomes" },
                            Comparison = ">",
                            Value = 8,
                        },
                        NamedRequirements = { DDT_guid.."LaterHammerLootRequirements" },
                    },
                }
            },
        },
        {
            WeightedList = true,
            Offers = 1,
            OptionsData =
            {
                { Name = "MaxHealthDrop" },
                { Name = "StackUpgrade", Cost = 100, ReplaceRequirements = { NamedRequirements = { "StackUpgradeLegal" }, } },
                { Name = "ShopHermesUpgrade", },
            },
        },
        {
            WeightedList = true,
            Offers = 1,
            OptionsData =
            {
                { Name = "MaxManaDrop", },
                {
                    Name = "SpellDrop",
                    Weight = 1.3,
                    ReplaceRequirements =
                    {
                        {
                            PathFalse = { "CurrentRun", "UseRecord", "SpellDrop" },
                        },
                        {
                            PathFalse = { "CurrentRun", "HubRewardLookup", "SpellDrop" },
                        },
                        {
                            PathFalse = { "MapState", "OfferedRewards", "SpellDrop" },
                        },
                        {
                            Path = { "GameState", "TextLinesRecord" },
                            HasAll = { "ArtemisFirstMeeting", "SeleneFirstPickUp" },
                        },
                        {
                            PathFalse = { "CurrentRun", "PendingSpellDrop" },
                        },
                        NamedRequirementsFalse = { "SurfaceRouteLockedByTyphonKill" },
                    }
                },
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

function mod.AddBossRushMoney()
    game.AddResource( "Money", config.shop_gold, _PLUGIN.guid .. "BossRush" )
    game.CurrentRun.CurrentRoom[_PLUGIN.guid .. "BossRushMoneyAdded"] = true
end

local function getEventIndex(events, functionName)
    for index, event in ipairs(events) do
        if event.FunctionName == functionName then
            return index
        end
    end
end

for _, roomName in pairs(shopRoomMap) do
    local roomData = game.RoomData[roomName]
    if roomData then
        roomData.StartUnthreadedEvents = roomData.StartUnthreadedEvents or {}
        local eventIndex = getEventIndex(roomData.StartUnthreadedEvents, _PLUGIN.guid .. "." .. "AddBossRushMoney")
        if not eventIndex then
            print("Adding money event for", roomData.Name)
            table.insert(roomData.StartUnthreadedEvents,
            {
                FunctionName = _PLUGIN.guid .. "." .. "AddBossRushMoney",
                GameStateRequirements =
                {
                    {
                        PathTrue = {"CurrentRun" , _PLUGIN.guid .. "BossRush"}
                    },
                    {
                        PathFalse = {"CurrentRun", "CurrentRoom", _PLUGIN.guid .. "BossRushMoneyAdded"}
                    }
                }
            })
        end
    end
end

function mod.SetupFountainVisited(source, args)
    game.CurrentRun.RoomCountCache = game.CurrentRun.RoomCountCache or {}
    game.CurrentRun.RoomCountCache[source.Name] = (game.CurrentRun.RoomCountCache[source.Name] or 0) + 1
end

if game.RoomData["D_Intro"] then
    local roomData = game.RoomData["D_Intro"]
    roomData.StartUnthreadedEvents = roomData.StartUnthreadedEvents or {}
    table.insert(roomData.StartUnthreadedEvents, {
        FunctionName = "NikkelM-Zagreus_Journey" .. "." .. "SpawnConsumables",
        Args =
        {
            Spawns =
            {
                {
                    ConsumableName = "CerberusKey",
                    DestinationId = 40055,
                }
            }
        },
        GameStateRequirements = {
            {
                PathTrue = {"CurrentRun" , _PLUGIN.guid .. "BossRush"}
            },
        }
    })
    table.insert(roomData.StartUnthreadedEvents, {
        FunctionName = _PLUGIN.guid .. "." .. "SetupFountainVisited",
        GameStateRequirements = {
            {
                PathTrue = {"CurrentRun" , _PLUGIN.guid .. "BossRush"}
            },
        }
    })
end

if game.RoomData["D_Hub"] then
    local roomData = game.RoomData["D_Hub"]
    roomData.StartUnthreadedEvents = roomData.StartUnthreadedEvents or {}
    table.insert(roomData.StartUnthreadedEvents, {
        FunctionName = "UnlockDoor",
        Args = { DoorId = 547460, RelockAllDoors = true, },
        GameStateRequirements = {
            {
                PathTrue = {"CurrentRun" , _PLUGIN.guid .. "BossRush"}
            },
        }
    })
    table.insert(roomData.StartUnthreadedEvents, {
        FunctionName = "ExitNPCPresentation",
        Args = {
            InitialWaitTime = 0.2,
            ObjectId = 547487,
            TeleportToId = 551568,
            DeleteId = 551569,
            InitialExitSound = "/VO/CerberusGrowl",
            FullFadeTime = 1.8,
            EndSound = "/Leftovers/Menu Sounds/EmoteAffection",
            UseAdditionalFootstepSounds = true,
            EndUnlockTextTable = { "ClearedCerberus", "ClearedCerberus", "ClearedCerberus", "ClearedCerberus", "ClearedCerberus_Alt1", "ClearedCerberus_Alt1", "ClearedCerberus_Alt1", "ClearedCerberus_Alt1", "ClearedCerberus_A", "ClearedCerberus_B", "ClearedCerberus_C", "ClearedCerberus_D", "ClearedCerberus_E", "ClearedCerberus_F", "ClearedCerberus_G", "ClearedCerberus_H", "ClearedCerberus_I", "ClearedCerberus_J", "ClearedCerberus_K", "ClearedCerberus_L", "ClearedCerberus_M", "ClearedCerberus_N", "ClearedCerberus_O", "ClearedCerberus_P", "ClearedCerberus_Q" },
            FootstepSound = "/Leftovers/SFX/FootstepsHuge",
            MoveSound = "/Leftovers/SFX/BallImpact",
            HeroVoiceLines = "ClearedCerberusVoiceLines"
        },
        GameStateRequirements = {
            {
                PathTrue = {"CurrentRun" , _PLUGIN.guid .. "BossRush"}
            },
        }
    })
end

modutil.mod.Path.Wrap("ChooseStartingRoom", function (base, currentRun, args)
    if currentRun[_PLUGIN.guid .. "BossRush"] and shopRoomMap[args.StartingBiome] and game.RoomData[shopRoomMap[args.StartingBiome]] then
        print("Configuring shop room as biome start", shopRoomMap[args.StartingBiome], args.StartingBiome)
        local roomData = game.CreateRoom(game.RoomData[shopRoomMap[args.StartingBiome]], args)
        if not game.Contains({"Q", "I", "Styx"}, args.StartingBiome) then
            roomData.StoreDataName = "BossRushWorldShop"
        end
        roomData.Starting = true
        roomData.RemoveTimerBlock = "InterBiome"
        roomData.BiomeStartRoom = true
        if game.Contains({"Tartarus", "Asphodel", "Elysium", "Styx"}, args.StartingBiome) then
            game.CurrentRun.ModsNikkelMHadesBiomesIsModdedRun = true
            currentRun.ModsNikkelMHadesBiomesIsModdedRun = true
        else
            game.CurrentRun.ModsNikkelMHadesBiomesIsModdedRun = false
            currentRun.ModsNikkelMHadesBiomesIsModdedRun = false
        end
        return roomData
    end
    return base(currentRun, args)
end)

modutil.mod.Path.Wrap("StartNewRun", function (base, ...)
    local currentRun = base(...)
    if currentRun.IsDreamRun then
        currentRun[_PLUGIN.guid .. "BossRush"] = true
        game.AddTrait( currentRun.Hero, "RestockBoon", "Common")
    end
    return currentRun
end)

modutil.mod.Path.Wrap("RemoveStoreItem", function (base, args)
    -- print("RemoveStoreItem", dump(game.CurrentRun.CurrentRoom.Store.StoreOptions))
    if not (game.CurrentRun == nil or game.CurrentRun.CurrentRoom == nil or game.CurrentRun.CurrentRoom.Store == nil) and game.CurrentRun[_PLUGIN.guid .. "BossRush"] then
        table.insert(game.CurrentRun.CurrentRoom.Store.StoreOptions, {Name = args.Name})
    end
    if game.CurrentRun == nil or game.CurrentRun.CurrentRoom == nil or game.CurrentRun.CurrentRoom.Store == nil or game.IsEmpty( game.CurrentRun.CurrentRoom.Store.StoreOptions ) then
		return
	end
    if game.CurrentRun[_PLUGIN.guid .. "BossRush"] then
        print("resetting FirstPurchase")
        game.CurrentRun.CurrentRoom.FirstPurchase = nil
    end
    local value = base(args)
    if game.CurrentRun[_PLUGIN.guid .. "BossRush"] then
        print("resetting FirstPurchase")
        game.CurrentRun.CurrentRoom.FirstPurchase = nil
    end
    return value
end)

modutil.mod.Path.Wrap("RestockWorldItem", function (base, replacedIndex, kitId, args)
    if game.CurrentRun[_PLUGIN.guid .. "BossRush"] and game.CurrentRun.CurrentRoom.StoreDataName == "BossRushWorldShop" then
        args.Name = _PLUGIN.guid .. "InvalidName"
    end
    local spawnedStoreItemsCopy = game.ShallowCopyTable(game.CurrentRun.CurrentRoom.Store.SpawnedStoreItems)
    -- print("RestockWorldItem before", dump(spawnedStoreItemsCopy))
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
    -- print("RestockWorldItem after", dump(game.CurrentRun.CurrentRoom.Store.SpawnedStoreItems))
end)