local previousConfig = {
    gauntlet_mode = {}
}

function DrawBossRushConfig()
    local value, checked, selected
    value, checked = rom.ImGui.Checkbox("Enable boss rush", config.enabled)
    if checked then
        config.enabled = value
    end

    if not config.gauntlet_mode.enabled then
        rom.ImGui.Text("    "); rom.ImGui.SameLine()
        rom.ImGui.Text("The amount gold given in each shop")
        rom.ImGui.Text("    "); rom.ImGui.SameLine()
        value, selected = rom.ImGui.SliderInt("###shopgold", config.shop_gold, 600, 1200, '%d%')
        if selected and value ~= previousConfig.shop_gold then
            config.shop_gold = value
            previousConfig.shop_gold = value
        end
    end

    value, checked = rom.ImGui.Checkbox("Enable gauntlet mode. Puts boss rush at end of run", config.gauntlet_mode.enabled)
    if checked then
        config.gauntlet_mode.enabled = value
    end

    if config.gauntlet_mode.enabled then
        rom.ImGui.Text("    "); rom.ImGui.SameLine()
        value, checked = rom.ImGui.Checkbox("Enable rest spot before starting boss rush", config.gauntlet_mode.starting_rest_spot)
        if checked then
            config.gauntlet_mode.starting_rest_spot = value
        end

        rom.ImGui.Text("    "); rom.ImGui.SameLine(); rom.ImGui.Text("Rest spot every")
        rom.ImGui.Text("    "); rom.ImGui.SameLine()
        value, selected = rom.ImGui.SliderInt("Bosses", config.gauntlet_mode.rest_frequency, 0, 12, '%d%')
        if selected and value ~= previousConfig.gauntlet_mode.rest_frequency then
            config.gauntlet_mode.rest_frequency = value
            previousConfig.gauntlet_mode.rest_frequency = value
        end
    end
end

rom.mods[DDT_guid].RegisterPluginImGui(DrawBossRushConfig, "Boss Rush")