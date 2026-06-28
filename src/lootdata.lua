mod.newLootData =
{
    AthenaBossRush =
    {
        InheritFrom = { "BaseLoot", "BaseSoundPackage" },
        UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
        GodLoot = false,
        AlwaysShowDefaultUseText = true,
        MenuTitle = "UpgradeChoiceMenu_Athena",
        Traits =
		{
			"InvulnerabilityDashBoon",
			"RetaliateInvulnerabilityBoon",
			"FocusLastStandBoon",
			"DeathDefianceRefillBoon",
			"AthenaProjectileBoon",
			"InvulnerabilityCastBoon",
			"ManaSpearBoon",

			"OlympianSpellCountBoon",
		},
		FlavorTextIds =
		{
			"AthenaUpgrade_FlavorText01",
			"AthenaUpgrade_FlavorText02",
			"AthenaUpgrade_FlavorText03",
		},
        GameStateRequirements =
        {
            {
                PathTrue = {"AllowBossRushLootInRuns"}
            }
        },
        LootColor = {175, 157, 255, 255},
		LightingColor = {175, 157, 255, 255},
        TreatAsGodLootByShops = true,
        LoadPackages = { "NPC_Athena_01", "Athena" },
        Color = { 255, 192, 203, 255 },
		SpawnSound = "/SFX/AthenaWrathHolyShield",
		UpgradeScreenOpenSound = "/SFX/AthenaWrathHolyShield",
		UpgradeSelectedSound = "/SFX/AthenaBoonChoice",
		Icon = "BoonSymbolAthena",
    },

    HadesBossRush =
    {
        InheritFrom = { "BaseLoot", "BaseSoundPackage" },
        UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
        AlwaysShowDefaultUseText = true,
        GodLoot = false,
        Icon = "BoonSymbolHades",
        TreatAsGodLootByShops = true,
		ExcludeFromLastRunBoon = true,
        IgnoreRestrictBoonChoices = true,
		IgnoreTempRarityBonus = true,
		BlockForceCommon = true,
        ManualRecordUse = false,
        BlockDoubleBoon = true,
        LightingColor = { 255, 0, 0, 255 },
		LootColor = { 242, 49, 46, 255 },
        Color = { 242, 49, 46, 255 },
        MenuTitle = "UpgradeChoiceMenu_Hades",
        GameStateRequirements =
        {
            {
                PathTrue = {"AllowBossRushLootInRuns"}
            }
        },
        Traits =
		{
			"HadesLifestealBoon",
			"HadesCastProjectileBoon",
			"HadesPreDamageBoon",
			"HadesChronosDebuffBoon",
			"HadesDashSweepBoon",
			"HadesDeathDefianceDamageBoon",
			"HadesManaUrnBoon",
			-- Legendary
			"HadesInvisibilityRetaliateBoon",
		},
		LoadPackages = { "NPC_Hades_Field_01", "Hades", },
        RarityChances =
		{
			Common = 1,
			Legendary = 0.1,
		},
		RarityRollOrder = { "Common", "Heroic" },
        FlavorTextIds =
		{
			"HadesUpgrade_FlavorText01",
			"HadesUpgrade_FlavorText02",
			"HadesUpgrade_FlavorText03",
		},
    },
    EchoBossRush =
    {
        InheritFrom = { "BaseLoot", "BaseSoundPackage" },
        UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
        AlwaysShowDefaultUseText = true,
        LoadPackages = { "Echo" },
        GodLoot = false,
        SubtitleColor = game.Color.EchoVoice,
        MenuTitle = "EchoChoiceMenu_Title",
		BoonInfoTitleText = "Codex_BoonInfo_Echo",
		LastRewardEligible = false,
		IgnoreStackBoost = true,
        ManualRecordUse = false,
        GameStateRequirements =
        {
            {
                PathTrue = {"AllowBossRushLootInRuns"}
            }
        },
        Traits =
		{
			"EchoLastReward",
			"EchoLastRunBoon",
			"EchoDeathDefianceRefill",
			"EchoDoubleLevelBoon",
			"DiminishingDodgeBoon",
			"DiminishingHealthAndManaBoon",
			"EchoDoubleShop",

			"EchoRepeatKeepsakeBoon",
		},
        FlavorTextIds =
		{
			"EchoChoiceMenu_FlavorText01",
		},
        OnUsedFunctionName = "EchoChoice",
        OnUsedFunctionArgs = game.PresetEventArgs.EchoBenefitChoices,
        [_PLUGIN.guid .. "RemoveInputBlock"] = true,
        [_PLUGIN.guid .. "OnCloseFinishedFunctionName"] = "EchoPostChoicePresentation"
    },
    IcarusBossRush =
    {
        InheritFrom = { "BaseLoot", "BaseSoundPackage" },
        UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
        GodLoot = false,
        AlwaysShowDefaultUseText = true,
        UpgradeScreenOpenSound = "/SFX/WeaponUpgradeHammerDrop2",
		UpgradeSelectedSound = "/SFX/HammerBoonChoice",
		UpgradeAcquiredAnimation = "MelinoeEquip",
        MenuTitle = "IcarusChoiceMenu_Title",
		BoonInfoTitleText = "Codex_BoonInfo_Icarus",
        ManualRecordUse = false,
		FlavorTextIds =
		{
			"IcarusChoiceMenu_FlavorText01",
		},
        GameStateRequirements =
        {
            {
                PathTrue = {"AllowBossRushLootInRuns"}
            }
        },
        LoadPackages = { "NPC_Icarus_01", "Icarus" },
		Traits =
		{
			"FocusAttackDamageTrait",
			"FocusSpecialDamageTrait",
			"OmegaExplodeBoon",
			"CastHazardBoon",
			"BreakInvincibleArmorBoon",
			"BreakExplosiveArmorBoon",
			"SupplyDropBoon",
			"UpgradeHammerBoon",
		},
        SubtitleColor = game.Color.IcarusVoice,
        OnUsedFunctionName = "IcarusBenefitChoice",
        OnUsedFunctionArgs = game.PresetEventArgs.IcarusBenefitChoices,
        [_PLUGIN.guid .. "RemoveInputBlock"] = true,
        [_PLUGIN.guid .. "OnCloseFinishedFunctionName"] = "IcarusPostChoicePresentation"
    },
    NarcBossRush =
    {
        InheritFrom = { "BaseLoot", "BaseSoundPackage" },
        UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
        GodLoot = false,
        AlwaysShowDefaultUseText = true,
        UpgradeScreenOpenSound = "/SFX/Menu Sounds/PortraitEmoteCheerfulSFX",
		UpgradeSelectedSound = "/SFX/Menu Sounds/KeepsakeNarcissusVial2",
		MenuTitle = "NarcissusGiftsMenu_Title",
		BoonInfoTitleText = "Codex_BoonInfo_Narcissus",
        ManualRecordUse = false,
        GameStateRequirements =
        {
            {
                PathTrue = {"AllowBossRushLootInRuns"}
            }
        },
		FlavorTextIds =
		{
			"NarcissusGiftsMenu_FlavorText01",
		},
        Traits =
		{
			"NarcissusA",
			"NarcissusB",
			"NarcissusC",
			"NarcissusD",
			"NarcissusE",
			"NarcissusF",
			"NarcissusH",
			"NarcissusI",

			"NarcissusG",
		},
        LoadPackages = { "Narcissus" },
		SubtitleColor = game.Color.NarcissusVoice,
        OnUsedFunctionName = "NarcissusBenefitChoice",
        OnUsedFunctionArgs = game.PresetEventArgs.NarcissusBenefitChoices,
        [_PLUGIN.guid .. "RemoveInputBlock"] = true,
        [_PLUGIN.guid .. "OnCloseFinishedFunctionName"] = "NarcissusPostChoicePresentation"
    },
    MedeaBossRush =
    {
        InheritFrom = { "BaseLoot", "BaseSoundPackage" },
        UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
        GodLoot = false,
        AlwaysShowDefaultUseText = true,
        LoadPackages = { "Medea" },
		SubtitleColor = game.Color.MedeaVoice,
        ManualRecordUse = false,
        GameStateRequirements =
        {
            {
                PathTrue = {"AllowBossRushLootInRuns"}
            }
        },
        Traits =
		{
			"HealingOnDeathCurse",
			"MoneyOnDeathCurse",
			"ManaOverTimeCurse",
			"SpawnDamageCurse",
			"ArmorPenaltyCurse",
			"SlowProjectileCurse",
			"DeathDefianceRetaliateCurse",

			"NewStatusDamage",
		},
        UpgradeAcquiredAnimation = "MelinoeSalute",
		UpgradeAcquiredAnimationDelay = 1.2,

		UpgradeScreenOpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA2",
		UpgradeSelectedSound = "/SFX/Menu Sounds/KeepsakeMedeaFleece2",
		MenuTitle = "MedeaCurseMenu_Title",
		BoonInfoTitleText = "Codex_BoonInfo_Medea",

		FlavorTextIds =
		{
			"MedeaCurseMenu_FlavorText01",
		},
        OnUsedFunctionName = "MedeaCurseChoice",
        OnUsedFunctionArgs = game.PresetEventArgs.MedeaCurseChoices,
        [_PLUGIN.guid .. "RemoveInputBlock"] = true,
        [_PLUGIN.guid .. "OnCloseFinishedFunctionName"] = "MedeaCursePostChoicePresentation"
    },
    ArtemisBossRush =
    {
        InheritFrom = { "BaseLoot", "BaseSoundPackage" },
        UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
        GodLoot = false,
        AlwaysShowDefaultUseText = true,
        LoadPackages = { "NPC_Artemis_Field_01", "Artemis" },
        TreatAsGodLootByShops = true,
        Icon = "BoonSymbolArtemis",
		LightingColor = {210, 255, 97, 255},
		LootColor = {110, 255, 0, 255},
		SubtitleColor = game.Color.ArtemisVoice,
		UseNarrativeContextArt = true,
		UpgradeScreenOpenSound = "/SFX/ArtemisBoonArrow",
		UpgradeSelectedSound = "/SFX/ArtemisBoonChoice",
        MenuTitle = "UpgradeChoiceMenu_Artemis",
        Traits =
		{
			"SupportingFireBoon",
			"CritBonusBoon",
			"DashOmegaBuffBoon",
			"HighHealthCritBoon",
			"InsideCastCritBoon",
			"OmegaCastVolleyBoon",
			"TimedCritVulnerabilityBoon",
			"FocusCritBoon",
			-- Legendary
			"SorceryCritBoon",
		},
        SpawnSound = "/SFX/ArtemisBoonArrow",
		FlavorTextIds =
		{
			"ArtemisUpgrade_FlavorText01",
			"ArtemisUpgrade_FlavorText02",
			"ArtemisUpgrade_FlavorText03",
		},
        GameStateRequirements =
        {
            {
                PathTrue = {"AllowBossRushLootInRuns"}
            }
        },
    },
    DioBossRush =
    {
        InheritFrom = { "BaseLoot", "BaseSoundPackage" },
        UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
        GodLoot = false,
        AlwaysShowDefaultUseText = true,
        LoadPackages = { "NPC_Dionysus_01", "Dionysus" },
        MenuTitle = "UpgradeChoiceMenu_Dionysus",
		UpgradeScreenOpenFunctionName = "DionysusChoiceScreenPresentation",
		UpgradeScreenOpenSound = "/SFX/DionysusBoonWineLaugh",
		UpgradeSelectedSound = "/SFX/DionysusBoonChoice",
		Icon = "BoonSymbolDionysus",
		LootColor = {200, 0, 255, 255},
		LightingColor = {200, 0, 255, 255},
        Traits =
		{
			"CastLobBoon",
			"HiddenMaxHealthBoon",
			"FirstHangoverBoon",
			"CombatEncounterHealBoon",
			"PowerDrinkBoon",
			"FogDamageBonusBoon",
			"BankBoon",

			-- Legendary
			"RandomBaseDamageBoon",
		},
		FlavorTextIds =
		{
			"DionysusUpgrade_FlavorText01",
			"DionysusUpgrade_FlavorText02",
			"DionysusUpgrade_FlavorText03",
		},
        GameStateRequirements =
        {
            {
                PathTrue = {"AllowBossRushLootInRuns"}
            }
        },
    },
    CirceBossRush =
    {
        InheritFrom = { "BaseLoot", "BaseSoundPackage" },
        UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
        GodLoot = false,
        AlwaysShowDefaultUseText = true,
        UpgradeAcquiredAnimation = "MelinoeSalute",
		UpgradeAcquiredAnimationDelay = 1.2,
        ManualRecordUse = false,
		UpgradeScreenOpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA3",
		UpgradeSelectedSound = "/SFX/Menu Sounds/KeepsakeCircePig2",
		MenuTitle = "CirceChoiceMenu_Title",
		BoonInfoTitleText = "Codex_BoonInfo_Circe",
        LoadPackages = { "NPC_Circe_01", "Circe" },
        GameStateRequirements =
        {
            {
                PathTrue = {"AllowBossRushLootInRuns"}
            }
        },
        Traits =
		{
			"CirceShrinkTrait",
			"CirceEnlargeTrait",
			"ArcanaRarityTrait",
			"HealAmplifyTrait",
			"DoubleFamiliarTrait",
			"RemoveShrineTrait",
			"RandomArcanaTrait",
			"CirceSorceryDamageBoon",

			"ExPolymorphBoon",
		},
		FlavorTextIds =
		{
			"CirceChoiceMenu_FlavorText01",
		},
        OnUsedFunctionName = "CirceBlessingChoice",
        OnUsedFunctionArgs = game.PresetEventArgs.CirceBlessingChoices,
        [_PLUGIN.guid .. "RemoveInputBlock"] = true,
        [_PLUGIN.guid .. "OnCloseFinishedFunctionName"] = "CirceBlessingPostChoicePresentation"
    },
    ArachneBossRush =
    {
        InheritFrom = { "BaseLoot", "BaseSoundPackage" },
        UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
        GodLoot = false,
        AlwaysShowDefaultUseText = true,
        UpgradeAcquiredAnimation = "MelinoeSalute",
        ManualRecordUse = false,
		UpgradeAcquiredAnimationDelay = 1.2,
        LoadPackages = { "Arachne", },
        UpgradeScreenOpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA3",
		UpgradeSelectedSound = "/SFX/Menu Sounds/KeepsakeArachneSash2",
		MenuTitle = "ArachneCostumeMenu_Title",
		BoonInfoTitleText = "Codex_BoonInfo_Arachne",
        GameStateRequirements =
        {
            {
                PathTrue = {"AllowBossRushLootInRuns"}
            }
        },
        FlavorTextIds =
		{
			"ArachneCostumeMenu_FlavorText01",
		},
		Traits =
		{
			"AgilityCostume",
			"ManaCostume",
			"VitalityCostume",
			"HighArmorCostume",
			"CastDamageCostume",
			"IncomeCostume",
			"SpellCostume",
			"EscalatingCostume",
		},
        OnUsedFunctionName = "ArachneCostumeChoice",
        OnUsedFunctionArgs = game.PresetEventArgs.ArachneCostumeChoices,
        [_PLUGIN.guid .. "RemoveInputBlock"] = true,
        [_PLUGIN.guid .. "OnCloseFinishedFunctionName"] = "ArachneArmorApply"
    }
}

if mod.IsZag then game.OverwriteTableKeys(mod.newLootData, {
    SisyphusBossRush =
    {
        InheritFrom = { "BaseLoot", "BaseSoundPackage" },
        UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
        GodLoot = false,
        AlwaysShowDefaultUseText = true,
        UpgradeAcquiredAnimation = "MelinoeSalute",
		UpgradeAcquiredAnimationDelay = 1.2,
        ManualRecordUse = false,
        UpgradeScreenOpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA",
		UpgradeSelectedSound = "/SFX/ArtemisBoonChoice",
		MenuTitle = "NPC_SisyphusAndBouldy_01",
        GameStateRequirements =
        {
            {
                PathTrue = {"AllowBossRushLootInRuns"}
            }
        },
		FlavorTextIds = {
			"Sisyphus_OfferText01",
		},
        Traits = {
			"ModsNikkelMHadesBiomesSisyphusHealing",
			"ModsNikkelMHadesBiomesSisyphusCentaurSoul",
			"ModsNikkelMHadesBiomesSisyphusMaxMana",
			"ModsNikkelMHadesBiomesSisyphusMoney",
			"ModsNikkelMHadesBiomesSisyphusMetapoints",
			"ModsNikkelMHadesBiomesSisyphusPomSlices",
			"ModsNikkelMHadesBiomesSisyphusTalentDrop",
		},
        OnUsedFunctionName = ZJ_guid .. "." .. "ModsNikkelMHadesBiomesBenefitChoice",
        OnUsedFunctionArgs = _G[ZJ_guid].PresetEventArgs.SisyphusBenefitChoices,
        [_PLUGIN.guid .. "RemoveInputBlock"] = true,
        [_PLUGIN.guid .. "OnCloseFinishedFunctionName"] = ZJ_guid .. "." .. "ModsNikkelMHadesBiomesNPCPostChoicePresentation",
    },
    EurydiceBossRush =
    {
        InheritFrom = { "BaseLoot", "BaseSoundPackage" },
        UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
        GodLoot = false,
        AlwaysShowDefaultUseText = true,
        UpgradeAcquiredAnimation = "MelinoeSalute",
		UpgradeAcquiredAnimationDelay = 1.2,
        ManualRecordUse = false,
        UpgradeScreenOpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA",
		UpgradeSelectedSound = "/Leftovers/Menu Sounds/TalismanPaperEquipLEGENDARY",
		MenuTitle = "NPC_Eurydice_01",
        GameStateRequirements =
        {
            {
                PathTrue = {"AllowBossRushLootInRuns"}
            }
        },
		FlavorTextIds = {
			"Eurydice_OfferText01",
		},
        Traits = {
			"ModsNikkelMHadesBiomesBuffSlottedBoonRarity",
			"ModsNikkelMHadesBiomesBuffMegaPom",
			"ModsNikkelMHadesBiomesBuffFutureBoonRarity",
		},
        OnUsedFunctionName = ZJ_guid .. "." .. "ModsNikkelMHadesBiomesBenefitChoice",
        OnUsedFunctionArgs = _G[ZJ_guid].PresetEventArgs.EurydiceBenefitChoices,
        [_PLUGIN.guid .. "RemoveInputBlock"] = true,
        [_PLUGIN.guid .. "OnCloseFinishedFunctionName"] = ZJ_guid .. "." .. "ModsNikkelMHadesBiomesNPCPostChoicePresentation",
    },
    PatroclusBossRush =
    {
        InheritFrom = { "BaseLoot", "BaseSoundPackage" },
        UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
        GodLoot = false,
        AlwaysShowDefaultUseText = true,
        UpgradeAcquiredAnimation = "MelinoeSalute",
		UpgradeAcquiredAnimationDelay = 1.2,
        ManualRecordUse = false,
		UpgradeScreenOpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA",
		UpgradeSelectedSound = "/SFX/ArtemisBoonChoice",
		MenuTitle = "NPC_Patroclus_01",
        GameStateRequirements =
        {
            {
                PathTrue = {"AllowBossRushLootInRuns"}
            }
        },
		FlavorTextIds = {
			"Patroclus_OfferText03",
		},
        Traits = {
			"ModsNikkelMHadesBiomesTemporaryDoorHealTrait_Patroclus",
			"ModsNikkelMHadesBiomesTemporaryImprovedWeaponTrait_Patroclus",
			"ModsNikkelMHadesBiomesBuffExtraChance",
			"ModsNikkelMHadesBiomesGainMaxHealthMinMana",
			"ModsNikkelMHadesBiomesGainMinHealthMaxMana",
		},
        OnUsedFunctionName = ZJ_guid .. "." .. "ModsNikkelMHadesBiomesBenefitChoice",
        OnUsedFunctionArgs = _G[ZJ_guid].PresetEventArgs.PatroclusBenefitChoices,
        [_PLUGIN.guid .. "RemoveInputBlock"] = true,
        [_PLUGIN.guid .. "OnCloseFinishedFunctionName"] = ZJ_guid .. "." .. "ModsNikkelMHadesBiomesNPCPostChoicePresentation",
    },
    OrpheusBossRush =
    {
        InheritFrom = { "BaseLoot", "BaseSoundPackage" },
        UsePromptOffsetX = 80,
		UsePromptOffsetY = 48,
        GodLoot = false,
        AlwaysShowDefaultUseText = true,
        UpgradeAcquiredAnimation = "MelinoeSalute",
		UpgradeAcquiredAnimationDelay = 1.2,
        ManualRecordUse = false,
		UpgradeScreenOpenSound = "/Leftovers/Menu Sounds/InfoPanelInURSA",
		UpgradeSelectedSound = "/SFX/ArtemisBoonChoice",
        MenuTitle = "NPC_Orpheus_01",
        GameStateRequirements =
        {
            {
                PathTrue = {"AllowBossRushLootInRuns"}
            }
        },
		FlavorTextIds = {
			"Orpheus_OfferText01",
		},
        Traits = {
			"ModsNikkelMHadesBiomesOrpheusChaosThemeBoon",
			"ModsNikkelMHadesBiomesOrpheusBossFightMusicBoon",
			"ModsNikkelMHadesBiomesOrpheusCharonShopThemeBoon",
			-- Priority Traits
			"ModsNikkelMHadesBiomesOrpheusOrpheusSong1Boon",
			"ModsNikkelMHadesBiomesOrpheusOrpheusSong2Boon",
			"ModsNikkelMHadesBiomesOrpheusEurydiceSong1Boon",
		},
        OnUsedFunctionName = ZJ_guid .. "." .. "ModsNikkelMHadesBiomesBenefitChoice",
        OnUsedFunctionArgs = _G[ZJ_guid].PresetEventArgs.OrpheusBenefitChoices,
        [_PLUGIN.guid .. "RemoveInputBlock"] = true,
        [_PLUGIN.guid .. "OnCloseFinishedFunctionName"] = ZJ_guid .. "." .. "ModsNikkelMHadesBiomesNPCPostChoicePresentation",
    }
})
end

game.OverwriteTableKeys(game.LootData, mod.newLootData)