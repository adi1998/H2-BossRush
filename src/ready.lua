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
                { Name = "RandomLoot", Weight = 4 },
                {
                    Name = "WeaponUpgradeDrop", Weight = 2.5, ResourceCosts = { Money = 120 },
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
                    Name = "WeaponUpgradeDrop", Weight = 2.5, ResourceCosts = { Money = 120 },
                    ReplaceRequirements =
                    {
                        {
                            PathTrue = { "GameState", "UseRecord", "WeaponUpgrade" },
                        },
                        NamedRequirements = { "LateHammerLootRequirements" },
                    },
                },
                {
                    Name = "WeaponUpgradeDrop", Weight = 2.5, ResourceCosts = { Money = 120 },
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
                    Name = "WeaponUpgradeDrop", Weight = 2.5, ResourceCosts = { Money = 120 },
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
                { Name = "MaxHealthDrop", Cost = 100, Weighted = 1.7 },
                { Name = "StackUpgrade", Cost = 120, ReplaceRequirements = { NamedRequirements = { "StackUpgradeLegal" }, } },
                { Name = "ShopHermesUpgrade", ResourceCosts = { Money = 100 }},
            },
        },
        {
            WeightedList = true,
            Offers = 1,
            OptionsData =
            {
                { Name = "MaxManaDrop" },
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
                    Weight = 1,
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
    local money = config.shop_gold * (game.GetTotalHeroTraitValue( "MoneyMultiplier", { IsMultiplier = true } ))
    money = game.round(money)
    game.AddResource( "Money", money, _PLUGIN.guid .. "BossRush" )
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

function mod.CompleteSurfaceShopItems()
    if game.CurrentRun.EnteredBiomes + 1 == game.GameData.FullRunBiomeCount then
        game.CompleteSurfaceShopItems()
    end
end

for _, roomName in pairs(shopRoomMap) do
    local roomData = game.RoomData[roomName]
    if roomData then
        roomData.StartUnthreadedEvents = roomData.StartUnthreadedEvents or {}
        local eventIndex = getEventIndex(roomData.StartUnthreadedEvents, _PLUGIN.guid .. "." .. "CompleteSurfaceShopItems")
        if not eventIndex then
            table.insert(roomData.StartUnthreadedEvents,
            {
                FunctionName = _PLUGIN.guid .. "." .. "CompleteSurfaceShopItems",
                GameStateRequirements =
                {
                    {
                        PathTrue = {"CurrentRun" , _PLUGIN.guid .. "BossRush"}
                    },
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
        FunctionName = ZJ_guid .. "." .. "SpawnConsumables",
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
    roomData.DistanceTriggers = roomData.DistanceTriggers or {}
    table.insert(roomData.DistanceTriggers, {
        TriggerObjectType = "ModsNikkelMHadesBiomes_NPC_Cerberus_Field_01",
        WithinDistance = 250,
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
        GameStateRequirements =
        {
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

modutil.mod.Path.Wrap("GenerateSellTraitValues", function (base, currentRoom, args)
    if game.CurrentRun and game.CurrentRun[_PLUGIN.guid .. "BossRush"] then
        args = args or {}
        args.ExclusionNames = args.ExclusionNames or {}
        table.insert(args.ExclusionNames, "RestockBoon")
    end
    return base(currentRoom, args)
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

local benefitChoiceFunctions = {
    "EchoChoice",
    "IcarusBenefitChoice",
    "NarcissusBenefitChoice",
    "MedeaCurseChoice",
    "CirceBlessingChoice",
    "ArachneCostumeChoice",
}

if mod.IsZag then
    table.insert(benefitChoiceFunctions, ZJ_guid .. "." .. "ModsNikkelMHadesBiomesBenefitChoice")
end

for _, choiceFunction in ipairs(benefitChoiceFunctions) do
    modutil.mod.Path.Wrap(choiceFunction, function (base, source, args, screen)
        if source[_PLUGIN.guid .. "RemoveInputBlock"] then
            screen = screen or {}
            args = args or {}
            if source[_PLUGIN.guid .. "OnCloseFinishedFunctionName"] then
                args.OverwriteTableKeys =
                {
                    OnCloseFinishedFunctionName = source[_PLUGIN.guid .. "OnCloseFinishedFunctionName"]
                }
            end
        end

        base(source, args, screen)

        if source[_PLUGIN.guid .. "RemoveInputBlock"] then
            game.RemoveInputBlock({ Name = "PlayTextLines" })
        end
    end)
end

local roomRewardRooms =
{
    "F_Boss01",
    "F_Boss02",

    "G_Boss01",
    "G_Boss02",

    "H_Boss01",
    "H_Boss02",

    "I_Boss01",

    "N_Boss01",
    "N_Boss02",

    "O_Boss01",
    "O_Boss02",

    "P_Boss01",

    "Q_Boss01",
    "Q_Boss02",

    "A_Boss01",
    "A_Boss02",
    "A_Boss03",

    "X_Boss01",
    "X_Boss02",

    "Y_Boss01",

    "D_Boss01",
}

function mod.SpawnNPCLoot(source, args)
    if game.CurrentRun[_PLUGIN.guid .. "BossRush"] and game.CurrentRun.EnteredBiomes < game.GameData.FullRunBiomeCount then
        local lootOptions = {}
        for lootName, _ in pairs(mod.newLootData) do
            if (game.CurrentRun.UseRecord[lootName] or 0) <= 0 then
                table.insert(lootOptions, lootName)
            end
        end
        local chosenLootOption = game.RemoveRandomValue(lootOptions)
        if chosenLootOption then
            game.CreateLoot({ Name = chosenLootOption, OffsetX = 100, SpawnPoint = game.CurrentRun.Hero.ObjectId, AutoLoadPackages = true})
        end
        chosenLootOption = game.RemoveRandomValue(lootOptions)
        if chosenLootOption and game.CurrentRun.EnteredBiomes + 1 == game.GameData.FullRunBiomeCount then
            game.CreateLoot({ Name = chosenLootOption, OffsetX = 150, SpawnPoint = game.CurrentRun.Hero.ObjectId, AutoLoadPackages = true})
        end
    end
end

local wrappedFunc = {}

for index, roomName in ipairs(roomRewardRooms) do
    local roomData = game.RoomData[roomName]
    if roomData then
        if not roomData.OnRoomRewardSpawnedFunctionName then
            roomData.OnRoomRewardSpawnedFunctionName = _PLUGIN.guid .. "." .. "SpawnNPCLoot"
        else
            local funcName = roomData.OnRoomRewardSpawnedFunctionName
            if not wrappedFunc[funcName] then
                modutil.mod.Path.Wrap(funcName, function (base, ...)
                    mod.SpawnNPCLoot()
                    return base(...)
                end)
                wrappedFunc[funcName] = true
            end
        end
    end
end

modutil.mod.Path.Wrap("GiveRandomConsumables", function (base, args, trait, contextArgs)
    if game.CurrentRun[_PLUGIN.guid .. "BossRush"] and (args.DestinationId == 591878 or args.DestinationId == 370001) then
        args.DestinationId = game.CurrentRun.Hero.ObjectId
        args.Force = 0
        args.ForceToValidLocation = true
    end
    return base(args, trait, contextArgs)
end)

modutil.mod.Path.Wrap("EchoLastReward", function (base, args)
    if game.CurrentRun[_PLUGIN.guid .. "BossRush"] then
        args.LootSourceId = nil
    end
    return base(args)
end)

modutil.mod.Path.Wrap("AttemptOpenUpgradeChoiceBoonInfo", function (base, screen, button)
    if mod.newLootData[screen.Source.Name] then
        return
    end
    return base(screen, button)
end)

if mod.IsZag then
    modutil.mod.Path.Wrap(ZJ_guid .. "." .. "ModsNikkelMHadesBiomesSisyphusDropPresentation", function (base, ...)
        if game.CurrentRun[_PLUGIN.guid .. "BossRush"] then
            return
        end
        return base(...)
    end)

    modutil.mod.Path.Wrap(ZJ_guid .. "." .. "ModsNikkelMHadesBiomesOrpheusBuff", function (base, ...)
        if game.CurrentRun[_PLUGIN.guid .. "BossRush"] then
            game.ActiveEnemies[390000] =
            {
                OrpheusSingsAgainRequirements =
                {
                    {
                        PathTrue = { "OrpheusSingsDuringBossRush" }
                    }
                }
            }
        end

        base(...)

        if game.CurrentRun[_PLUGIN.guid .. "BossRush"] then
            game.ActiveEnemies[390000] = nil
        end
    end)
end