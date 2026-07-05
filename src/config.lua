local config = {
  enabled = true;
  shop_gold = 800;
  gauntlet_mode =
  {
    enabled = false;
    rest_frequency = 2;
    starting_rest_spot = true;
  }
}

local configDesc = {
  shop_gold = "The amount gold give tot he player in each shop";
  gauntlet_mode =
  {
    enabled = "Puts the boss rush at the end of the Dream Dive";
    rest_frequency = "Number of bosses before a rest spot appears (gauntlet_mode only).\nSet it to 0 or a really high number to disable any rest spots";
    starting_rest_spot = "Rest spot before the final gauntlet begins";
  }
}

return config, configDesc