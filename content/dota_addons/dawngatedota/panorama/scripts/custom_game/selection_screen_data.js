var BuildShaperChoice, OnSpiritgateSelectShaper, RebuildPlayerPanels, i, len, shaper_choice_remaps, shaper_choices_panel, shaper_choices_table, shaper_name, shaper_portrait_row, shaper_portrait_row_panel, shaper_portrait_x, shapers_with_custom_portrait;

shaper_choices_table = ["npc_dota_hero_rattletrap", "npc_dota_hero_pudge", "npc_dota_hero_undying", "npc_dota_hero_vengefulspirit", "npc_dota_hero_lycan", "npc_dota_hero_beastmaster", "npc_dota_hero_spectre", "npc_dota_hero_meepo", "npc_dota_hero_life_stealer", "npc_dota_hero_axe", "npc_dota_hero_skeleton_king", "npc_dota_hero_legion_commander", "npc_dota_hero_crystal_maiden", "npc_dota_hero_earth_spirit", "npc_dota_hero_bloodseeker", "npc_dota_hero_naga_siren", "npc_dota_hero_templar_assassin", "npc_dota_hero_oracle"];

shapers_with_custom_portrait = ["npc_dota_hero_undying"];

shaper_choices_panel = $("#ShaperChoicesPanel");

shaper_choices_panel.RemoveAndDeleteChildren();

shaper_portrait_x = 0;

shaper_portrait_row = 0;

shaper_portrait_row_panel = null;

BuildShaperChoice = function(shaper_choice_name) {
  var PressFunction, shaper_choice_centered_panel, shaper_choice_panel, shaper_choice_panel_image, shaper_choice_panel_label;
  shaper_portrait_x = shaper_portrait_x + 1;
  if (shaper_portrait_row === 0 || shaper_portrait_x > 7) {
    shaper_portrait_row_panel = $.CreatePanel("Panel", shaper_choices_panel, "ShaperChoiceRow");
    shaper_portrait_row_panel.AddClass("flow-right");
    shaper_portrait_row_panel.style.height = "32%";
    shaper_portrait_row_panel.style.width = "98%";
    shaper_portrait_row += 1;
    shaper_portrait_x = 1;
  }
  shaper_choice_panel = $.CreatePanel("Panel", shaper_portrait_row_panel, "ShaperChoice-" + shaper_choice_name);
  shaper_choice_panel.AddClass("fill-height");
  shaper_choice_panel.AddClass("even-space-horiz");
  shaper_choice_centered_panel = $.CreatePanel("Button", shaper_choice_panel, "ShaperChoiceCentered-" + shaper_choice_name);
  shaper_choice_centered_panel.AddClass("content-panel");
  shaper_choice_centered_panel.AddClass("fill-height");
  shaper_choice_centered_panel.style.width = "height-percentage(100%)";
  shaper_choice_centered_panel.style.align = "center center";
  PressFunction = function(name) {
    return function() {
      var keys;
      keys = {
        pid: Game.GetLocalPlayerID(),
        shaper: name
      };
      return GameEvents.SendCustomGameEventToServer("SpiritgateSelectShaper", keys);
    };
  };
  shaper_choice_centered_panel.SetPanelEvent("onactivate", PressFunction(shaper_choice_name));
  shaper_choice_panel_image = null;
  if (shapers_with_custom_portrait.indexOf(shaper_choice_name) >= 0) {
    shaper_choice_panel_image = $.CreatePanel("Image", shaper_choice_centered_panel, "ShaperChoice-" + shaper_choice_name + "-Image");
    shaper_choice_panel_image.SetImage("file://{images}/custom_game/heroes/" + shaper_choice_name + "/portrait.png");
    shaper_choice_panel_image.SetScaling("stretch-to-cover-preserve-aspect");
  } else {
    shaper_choice_panel_image = $.CreatePanel("DOTAHeroImage", shaper_choice_centered_panel, "ShaperChoice-" + shaper_choice_name + "-Image");
    shaper_choice_panel_image.heroname = shaper_choice_name;
    shaper_choice_panel_image.heroimagestyle = "portrait";
  }
  shaper_choice_panel_image.AddClass("fill-width");
  shaper_choice_panel_image.style.height = "width-percentage(125%)";
  shaper_choice_panel_label = $.CreatePanel("Label", shaper_choice_centered_panel, "ShaperChoiceLabel-" + shaper_choice_name);
  shaper_choice_panel_label.style.fontSize = "20px";
  shaper_choice_panel_label.style.textShadow = "0px 0px 3px 2.0 #333333;";
  shaper_choice_panel_label.text = $.Localize(shaper_choice_name);
};

shaper_choice_remaps = [];

RebuildPlayerPanels = function() {
  var BuildPlayerPanel, bad_team_ids, good_team_ids, i, j, len, len1, player, player_id, results;
  player = Game.GetLocalPlayerID();
  good_team_ids = Game.GetPlayerIDsOnTeam(DOTATeam_t.DOTA_TEAM_GOODGUYS);
  bad_team_ids = Game.GetPlayerIDsOnTeam(DOTATeam_t.DOTA_TEAM_BADGUYS);
  $("#GoodTeamPanelPlayers").RemoveAndDeleteChildren();
  $("#BadTeamPanelPlayers").RemoveAndDeleteChildren();
  BuildPlayerPanel = function(player_id, team) {
    var new_heroname, panel, panel_selected_hero, panel_selected_hero_name, panel_selected_hero_name_container, panel_selected_role, panel_steam_icon;
    panel = null;
    if (team === DOTATeam_t.DOTA_TEAM_GOODGUYS) {
      panel = $.CreatePanel("Panel", $("#GoodTeamPanelPlayers"), "PlayerSelectInfo" + player_id);
    } else {
      panel = $.CreatePanel("Panel", $("#BadTeamPanelPlayers"), "PlayerSelectInfo" + player_id);
    }
    panel.AddClass("player-select-info");
    if (team === DOTATeam_t.DOTA_TEAM_GOODGUYS) {
      panel.AddClass("player-select-info-mortal");
    }
    panel.AddClass("fill");
    panel.AddClass("content-panel");
    panel.AddClass("flow-right");
    panel_steam_icon = $.CreatePanel("DOTAAvatarImage", panel, "PlayerSelectInfo" + player_id + "AvatarImage");
    panel_steam_icon.AddClass("square");
    panel_steam_icon.AddClass("even-space-horiz");
    panel_steam_icon.AddClass("margin-4");
    panel_steam_icon.steamid = Game.GetPlayerInfo(player_id).player_steamid;
    panel_selected_role = $.CreatePanel("Image", panel, "PlayerSelectInfo" + player_id + "RoleImage");
    panel_selected_role.AddClass("square");
    panel_selected_role.AddClass("even-space-horiz");
    panel_selected_role.AddClass("margin-4");
    panel_selected_role.SetImage("file://{images}/custom_game/roles/role_tactician.png");
    panel_selected_hero = null;
    if (Game.GetPlayerInfo(player_id) !== void 0) {
      new_heroname = Game.GetPlayerInfo(player_id).player_selected_hero;
    } else {
      new_heroname = "npc_dota_hero_rattletrap";
    }
    if (shaper_choice_remaps[player_id] !== void 0) {
      new_heroname = shaper_choice_remaps[player_id];
    }
    if (new_heroname === "npc_dota_hero_undying") {
      panel_selected_hero = $.CreatePanel("Image", panel, "PlayerSelectInfo" + player_id + "HeroNameContainer");
      panel_selected_hero.AddClass("hero-icon");
      panel_selected_hero.AddClass("even-space-horiz");
      panel_selected_hero.AddClass("margin-4");
      panel_selected_hero.SetScaling("stretch-to-cover-preserve-aspect");
      panel_selected_hero.SetImage("file://{images}/custom_game/heroes/npc_dota_hero_undying/landscape.png");
    } else {
      panel_selected_hero = $.CreatePanel("DOTAHeroImage", panel, "PlayerSelectInfo" + player_id + "HeroImage");
      panel_selected_hero.AddClass("hero-icon");
      panel_selected_hero.AddClass("even-space-horiz");
      panel_selected_hero.AddClass("margin-4");
      panel_selected_hero.heroname = new_heroname;
    }
    panel_selected_hero_name_container = $.CreatePanel("Panel", panel, "PlayerSelectInfo" + player_id + "HeroNameContainer");
    panel_selected_hero_name_container.AddClass("content-panel");
    panel_selected_hero_name_container.AddClass("margin-4");
    panel_selected_hero_name_container.AddClass("fill");
    panel_selected_hero_name = $.CreatePanel("Label", panel_selected_hero_name_container, "PlayerSelectInfo" + player_id + "HeroName");
    panel_selected_hero_name.AddClass("fill-height");
    panel_selected_hero_name.AddClass("text-center");
    return panel_selected_hero_name.text = $.Localize(new_heroname);
  };
  for (i = 0, len = good_team_ids.length; i < len; i++) {
    player_id = good_team_ids[i];
    BuildPlayerPanel(parseInt(good_team_ids[player_id]), DOTATeam_t.DOTA_TEAM_GOODGUYS);
  }
  results = [];
  for (j = 0, len1 = bad_team_ids.length; j < len1; j++) {
    player_id = bad_team_ids[j];
    results.push(BuildPlayerPanel(parseInt(bad_team_ids[player_id]), DOTATeam_t.DOTA_TEAM_BADGUYS));
  }
  return results;
};

OnSpiritgateSelectShaper = function(keys) {
  var pid, shaper;
  pid = keys.pid;
  shaper = keys.shaper;
  shaper_choice_remaps[pid] = shaper;
  return RebuildPlayerPanels();
};

GameEvents.Subscribe("SpiritgateSelectShaper", OnSpiritgateSelectShaper);

RebuildPlayerPanels();

for (i = 0, len = shaper_choices_table.length; i < len; i++) {
  shaper_name = shaper_choices_table[i];
  BuildShaperChoice(shaper_name);
}
