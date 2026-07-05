local biomeRoomMap =
{
    F =
    {
        RoomName = "F_Boss01",
        RivalsRoomName = "F_Boss02",
    },
    G =
    {
        RoomName = "G_Boss01",
        RivalsRoomName = "G_Boss02",
    },
    H =
    {
        RoomName = "H_Boss01",
        RivalsRoomName = "H_Boss02",
    },
    I =
    {
        RoomName = "I_Boss01",
        RivalsRoomName = "I_Boss01",
    },
    N =
    {
        RoomName = "N_Boss01",
        RivalsRoomName = "N_Boss02",
    },
    O =
    {
        RoomName = "O_Boss01",
        RivalsRoomName = "O_Boss02",
    },
    P =
    {
        RoomName = "P_Boss01",
        RivalsRoomName = "P_Boss01",
    },
    Q =
    {
        RoomName = "Q_Boss01",
        RivalsRoomName = "Q_Boss02",
    }
}

modutil.mod.Path.Wrap("IsBossDifficultyShrineUpgradeActive", function (base, source, args)
    if game.CurrentRun and game.CurrentRun.IsDreamRun and game.CurrentRun[_PLUGIN.guid .. "BossRushGauntlet"] then
        args = args or {}

        if not game.CurrentRun[_PLUGIN.guid .. "GauntletStarted"] then
            return false
	    end

        if game.CurrentRun.IsDreamRun and game.CurrentRun.EnteredBiomes > 0 then
            -- Block VoR boss encounters in dream runs if they've never been seen before
            local latestBiomeVisited = game.CurrentRun[_PLUGIN.guid .. "GauntletBossList"][game.CurrentRun[_PLUGIN.guid .. "NextGauntletBossIndex"]] or "F"
            local encounterMapData = game.BossDifficultyShrineEncounterBiomeMap[latestBiomeVisited]
            if encounterMapData.OnlyRequireSeen then
                return game.GameState.EncountersOccurredCache[encounterMapData.Encounter]
            else
                return game.GameState.EncountersCompletedCache[encounterMapData.Encounter]
            end
        end
        return true
    end
    return base(source, args)
end)

function mod.SelectNextBossRoom()
    local bossBiome = game.CurrentRun[_PLUGIN.guid .. "GauntletBossList"][game.CurrentRun[_PLUGIN.guid .. "NextGauntletBossIndex"]]

    bossBiome = "P"

    local encounterMapData = game.BossDifficultyShrineEncounterBiomeMap[bossBiome]
    local skipRivals = not game.GameState.EncountersCompletedCache[encounterMapData.Encounter]
    if encounterMapData.OnlyRequireSeen then
        skipRivals = not game.GameState.EncountersOccurredCache[encounterMapData.Encounter]
    end
    local bossRoomName = biomeRoomMap[bossBiome][(skipRivals and "RoomName") or "RivalsRoomName"]
    return bossRoomName
end

function mod.ExitToBoss()
    game.CurrentRun.CurrentRoom.ExitFunctionName = "DreamRunRoomExitPresentation"
    local nextRoomName = mod.SelectNextBossRoom()
    local roomArgs =
    {
        RoomOverrides =
        {
            PlayBiomeMusic = true,
        },
    }
    local nextRoom = game.CreateRoom( game.RoomData[nextRoomName], roomArgs )
    game.LeaveRoom( game.CurrentRun, { Room = nextRoom } )
end

function mod.ExitToRestSpot()
    game.CurrentRun.CurrentRoom.ExitFunctionName = "DreamRunRoomExitPresentation"
    local nextRoomName = game.RoomSets.Dream[math.random(2,4)]
    local nextRoom = game.CreateRoom( game.RoomData[nextRoomName] )
    game.LeaveRoom( game.CurrentRun, { Room = nextRoom } )
end

modutil.mod.Path.Wrap("CheckDreamBiomeCompletion", function (base, ...)
    if game.CurrentRun[_PLUGIN.guid .. "BossRushGauntlet"] and game.CurrentRun.EnteredBiomes == game.GameData.FullRunBiomeCount then
        if not game.CurrentRun.CurrentRoom.UseRecord.DreamPointsDrop then
            return false
        end

        game.TraitTrayScreenClose( game.ActiveScreens.TraitTrayScreen )
        game.CloseBoonInfoScreen( game.ActiveScreens.BoonInfo )
        game.CloseCodexScreen( game.ActiveScreens.Codex )
        game.CloseInventoryScreen( game.ActiveScreens.InventoryScreen )

        if game.CurrentRun[_PLUGIN.guid .. "NextGauntletBossIndex"] then
            game.CurrentRun[_PLUGIN.guid .. "NextGauntletBossIndex"] = game.CurrentRun[_PLUGIN.guid .. "NextGauntletBossIndex"] + 1
        end

        if game.CurrentRun.EnteredBiomes == game.GameData.FullRunBiomeCount and
        not game.CurrentRun[_PLUGIN.guid .. "GauntletStarted"] then
                game.CurrentRun[_PLUGIN.guid .. "GauntletStarted"] = true
                game.CurrentRun[_PLUGIN.guid .. "GauntletBossList"] = game.DeepCopyTable(game.CurrentRun[DDT_guid .. "GeneratedRoute"])
                game.CurrentRun[_PLUGIN.guid .. "NextGauntletBossIndex"] = 1
        end

        if game.CurrentRun[_PLUGIN.guid .. "NextGauntletBossIndex"] > game.CurrentRun.EnteredBiomes then
            game.thread(game.EndDreamRunPresentation)
        else
            if game.CurrentRun[_PLUGIN.guid .. "NextGauntletBossIndex"] == 1 then
                if config.gauntlet_mode.starting_rest_spot then
                    mod.ExitToRestSpot()
                else
                    mod.ExitToBoss()
                end
            elseif config.gauntlet_mode.rest_frequency > 0 and (game.CurrentRun[_PLUGIN.guid .. "NextGauntletBossIndex"] - 1) % config.gauntlet_mode.rest_frequency == 0 then
                mod.ExitToRestSpot()
            else
                mod.ExitToBoss()
            end
        end
        return true
    end
    return base(...)
end)

modutil.mod.Path.Wrap("EnterNextDreamBiome", function (base, source, args)
    if game.CurrentRun[_PLUGIN.guid .. "GauntletStarted"] then
        game.AddInputBlock({ Name = "EnterNextDreamBiome" })

        local roomArgs =
	    {
            RoomOverrides =
            {
                PlayBiomeMusic = true,
            },
        }

        local nextRoomName = mod.SelectNextBossRoom()
        local nextRoom = game.CreateRoom( game.RoomData[nextRoomName], roomArgs )
        game.LeaveRoom( game.CurrentRun, { Room = nextRoom } )
        game.RemoveInputBlock({ Name = "EnterNextDreamBiome" })
        return
    end
    return base(source, args)
end)

local revertPlsyBiomeMusicMap = {}

modutil.mod.Path.Wrap("KillHero", function (base, ...)
    for roomName, _ in pairs(revertPlsyBiomeMusicMap) do
        game.RoomData[roomName].PlayBiomeMusic = nil
    end
    revertPlsyBiomeMusicMap = {}
    return base(...)
end)

modutil.mod.Path.Wrap("StartRoomMusic", function (base, currentRun, currentRoom)
    if currentRun[_PLUGIN.guid .. "GauntletStarted"] and not string.match(currentRoom.Name, "Dream_PostBoss") then
        local roomData = game.RoomData[currentRoom.Name] or currentRoom
        roomData.PlayBiomeMusic = true
        revertPlsyBiomeMusicMap[roomData.Name] = true
    end
    return base(currentRun, currentRoom)
end)

modutil.mod.Path.Wrap("UpdateRunHistoryCache", function (base, ...)
    base(...)
    if game.CurrentRun and game.CurrentRun[_PLUGIN.guid .. "GauntletStarted"] then
        game.CurrentRun.BiomeDepthCache = 10
    end
end)

for _, track in ipairs(game.MusicTrackData.P) do
    track.GameStateRequirements =
    {
        OrRequirements =
        {
            track.GameStateRequirements,
            {
                {
                    PathTrue = {"CurrentRun", _PLUGIN.guid .. "GauntletStarted"}
                }
            }
        }
    }
end