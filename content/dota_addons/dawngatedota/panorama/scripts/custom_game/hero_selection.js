var AddPlayer, BuildPlayerPanel, BuildSelections, InspectHero, LockSelections, OnChatSubmitted, OnSelectRole, OnSelectShaper, OnSpiritgateChat, OnTimeOver, OnTimeUpdate, RebuildPlayers, RoleMouseOut, RoleMouseOver, RoleSelect, currentMortalIndex, currentSpiritIndex, owned_skins, playerIDToIndex, playerIDToTeam, shaper_choices_table, skin_map;

$("#HeroSelectionRoot").style.width = "0%";

skin_map = {
  "npc_dota_hero_undying": ["rotting_tomb_ramen_tomb"]
};

owned_skins = [];

$.AsyncWebRequest('http://spiritgate.net/api/get_skins/' + Game.GetLocalPlayerInfo().player_steamid, {
  type: 'GET',
  data: {},
  complete: function(a, b, c, d, e) {
    var i, j, len, results, skin;
    owned_skins = a['responseText'].split(",");
    results = [];
    for (i = j = 0, len = owned_skins.length; j < len; i = ++j) {
      skin = owned_skins[i];
      results.push(owned_skins[i] = skin.substring(0, skin.length - 1).replace(":", "_").replace(" ", "_"));
    }
    return results;
  },
  timeout: 50000
});

BuildPlayerPanel = function(index) {
  var player_avatar_panel, player_panel, player_panel_bottom, player_panel_main, player_panel_name, player_panel_role_panel, player_panel_role_panel_image, player_panel_shaper_panel, player_panel_shaper_panel_image, team, team_panel;
  team_panel = $("#MortalTeam");
  team = "Mortal";
  if (index > 4) {
    team = "Spirit";
    team_panel = $("#SpiritTeam");
    index -= 5;
  }
  player_panel = $.CreatePanel("Panel", team_panel, team + "PlayerPanel" + index);
  player_panel.AddClass("even-space-vertical");
  player_panel.AddClass("flow-right");
  player_panel.style.width = "100%";
  player_avatar_panel = $.CreatePanel("DOTAAvatarImage", player_panel, team + "PlayerAvatar" + index);
  player_avatar_panel.AddClass("margin-4");
  player_avatar_panel.AddClass("square");
  player_avatar_panel.AddClass("fill-height");
  player_avatar_panel.AddClass("steam-avatar");
  player_panel_main = $.CreatePanel("Panel", player_panel, team + "PlayerPanelMain" + index);
  player_panel_main.AddClass("fill");
  player_panel_main.AddClass("flow-down");
  player_panel_bottom = $.CreatePanel("Panel", player_panel_main, team + "PlayerPanelBottom" + index);
  player_panel_bottom.style.width = "100%";
  player_panel_bottom.style.height = "50%";
  player_panel_bottom.AddClass("flow-right");
  player_panel_role_panel = $.CreatePanel("Panel", player_panel_bottom, team + "PlayerPanelRolePanel" + index);
  player_panel_role_panel.style.width = "fill-parent-flow(1)";
  player_panel_role_panel.style.height = "100%";
  player_panel_role_panel_image = $.CreatePanel("Image", player_panel_role_panel, team + "PlayerPanelRoleImage" + index);
  player_panel_role_panel_image.style.width = "height-percentage(100%)";
  player_panel_role_panel_image.style.height = "100%";
  player_panel_shaper_panel = $.CreatePanel("Panel", player_panel_bottom, team + "PlayerPanelShaperPanel" + index);
  player_panel_shaper_panel.style.width = "fill-parent-flow(1)";
  player_panel_shaper_panel.style.height = "100%";
  player_panel_shaper_panel_image = $.CreatePanel("Image", player_panel_shaper_panel, team + "PlayerPanelShaperImage" + index);
  player_panel_shaper_panel_image.style.width = "height-percentage(100%)";
  player_panel_shaper_panel_image.style.height = "100%";
  player_panel_name = $.CreatePanel("Label", player_panel_main, team + "PlayerPanelName" + index);
  player_panel_name.style.width = "100%";
  player_panel_name.style.height = "50%";
  player_panel_name.style.fontSize = "26px";
  return player_panel_name.style.textAlign = "center";
};

currentMortalIndex = 0;

currentSpiritIndex = 0;

playerIDToIndex = {};

playerIDToTeam = {};

AddPlayer = function(index, team, pos_index) {
  var playerInfo;
  playerInfo = Game.GetPlayerInfo(index);
  $('#' + team + "PlayerAvatar" + pos_index).steamid = playerInfo.player_steamid;
  $('#' + team + "PlayerPanelName" + pos_index).text = playerInfo.player_name;
  $('#' + team + "PlayerPanelRoleImage" + pos_index).SetImage("file://{images}/custom_game/roles/role_tactician.png");
  return $('#' + team + "PlayerPanelShaperImage" + pos_index).SetImage("file://{images}/heroes/icons/npc_dota_hero_rattletrap.png");
};

RebuildPlayers = function() {
  var doMortal, doSpirit, index, j, k, l, len, len1, mortalPlayers, player_index, results, spiritPlayers;
  playerIDToTeam = {};
  playerIDToIndex = {};
  currentMortalIndex = 0;
  currentSpiritIndex = 0;
  $("#MortalTeam").RemoveAndDeleteChildren();
  $("#SpiritTeam").RemoveAndDeleteChildren();
  for (index = j = 0; j <= 9; index = ++j) {
    BuildPlayerPanel(index);
  }
  mortalPlayers = Game.GetPlayerIDsOnTeam(DOTATeam_t.DOTA_TEAM_GOODGUYS);
  spiritPlayers = Game.GetPlayerIDsOnTeam(DOTATeam_t.DOTA_TEAM_BADGUYS);
  doMortal = function(player_index) {
    AddPlayer(player_index, "Mortal", currentMortalIndex);
    playerIDToIndex[player_index] = currentMortalIndex;
    playerIDToTeam[player_index] = "Mortal";
    return currentMortalIndex++;
  };
  doSpirit = function(player_index) {
    AddPlayer(player_index, "Spirit", currentSpiritIndex);
    playerIDToIndex[player_index] = currentSpiritIndex;
    playerIDToTeam[player_index] = "Spirit";
    return currentSpiritIndex++;
  };
  for (k = 0, len = mortalPlayers.length; k < len; k++) {
    player_index = mortalPlayers[k];
    doMortal(player_index);
  }
  results = [];
  for (l = 0, len1 = spiritPlayers.length; l < len1; l++) {
    player_index = spiritPlayers[l];
    results.push(doSpirit(player_index));
  }
  return results;
};

RebuildPlayers();

shaper_choices_table = {
  "npc_dota_hero_rattletrap": ["ancient_babysitter_reconfigure", "ancient_babysitter_access_memory_sentinel", "ancient_babysitter_flashback", "ancient_babysitter_final_protocol", "pure_shaper"],
  "npc_dota_hero_pudge": ["desert_raider_dust_devil", "desert_raider_quicksand", "desert_raider_heat_wave", "desert_raider_the_big_haul", "focus_shaper_double_edge"],
  "npc_dota_hero_undying": ["rotting_tomb_forgotten_tombs", "rotting_tomb_chilling_presence", "rotting_tomb_desecrated_ground", "rotting_tomb_deathfog", "mindrotting_shaper"],
  "npc_dota_hero_vengefulspirit": ["elegant_dancer_gale", "elegant_dancer_stance_dance", "elegant_dancer_unleash_slipstream", "elegant_dancer_wrath_of_heaven", "wind_shaper"],
  "npc_dota_hero_lycan": ["alpha_soul_rend", "alpha_unyielding_march", "alpha_heart_eater", "alpha_ravenous_pack", "health_shaper"],
  "npc_dota_hero_beastmaster": ["enforcer_revolt", "enforcer_unbreakable", "enforcer_onslaught", "enforcer_uprising", "pure_shaper"],
  "npc_dota_hero_spectre": ["art_prodigy_splatter", "art_prodigy_muse", "art_prodigy_desaturate", "art_prodigy_prismatic_vortex", "pure_shaper"],
  "npc_dota_hero_meepo": ["tangled_dreamer_nightmare", "tangled_dreamer_dreamwrap", "tangled_dreamer_ripple", "tangled_dreamer_reverie", "pure_shaper"],
  "npc_dota_hero_life_stealer": ["flesh_skewer", "flesh_grievous_wounds", "flesh_jagged_volley", "flesh_splintering_spines", "pure_shaper"],
  "npc_dota_hero_axe": ["cerulean_whirling_strike", "cerulean_ritual_bulwark", "cerulean_impale", "cerulean_shores_calling", "pure_shaper"],
  "npc_dota_hero_skeleton_king": ["hell_devourer_sentinel_strike", "hell_devourer_curse_of_weakness", "hell_devourer_devour", "hell_devourer_damnation", "pure_shaper_mark_of_consumption"],
  "npc_dota_hero_legion_commander": ["high_huntress_branching_blade", "high_huntress_the_chase", "high_huntress_wing_clip", "high_huntress_final_flight", "focus_shaper"],
  "npc_dota_hero_crystal_maiden": ["winters_bride_ice_lance", "winters_bride_iceberg", "winters_bride_shatter", "winters_bride_avalanche", "frost_shaper"],
  "npc_dota_hero_earth_spirit": ["sculptor_inspiring_strike", "sculptor_embrace", "sculptor_kinetic_sculpture", "sculptor_masterpiece", "inspired_shaper"],
  "npc_dota_hero_bloodseeker": ["survivor_gouge", "survivor_blinding_speed", "survivor_crippling_blow", "survivor_wrath", "rage_shaper"],
  "npc_dota_hero_naga_siren": ["typhoon_feeding_frenzy", "typhoon_waverider", "typhoon_tidal_prison", "typhoon_riptide", "momentum_shaper"],
  "npc_dota_hero_templar_assassin": ["merchant_princess_collateral", "merchant_princess_gold_standard", "merchant_princess_waltz", "merchant_princess_final_payment", "pure_shaper_compound_interest"],
  "npc_dota_hero_oracle": ["loremaster_chains_of_fate", "loremaster_burden_of_knowledge", "loremaster_great_rift", "loremaster_final_chapter", "pure_shaper"],
  "npc_dota_hero_invoker": ["mad_king_captivate", "mad_king_flourish", "mad_king_endless_delights", "mad_king_finale", "pure_shaper"],
  "npc_dota_hero_queenofpain": ["purifier_needle", "purifier_pure_blood", "purifier_leech", "purifier_exsanguinate", "health_shaper_pulse"],
  "npc_dota_hero_phantom_assassin": ["noble_shadow_night_strike", "noble_shadow_duskmantle", "noble_shadow_shadowstep", "noble_shadow_nox_aeterna", "pure_shaper_shadow_fury"],
  "npc_dota_hero_spirit_breaker": ["shepherd_sheep_toss", "shepherd_battle_cry", "shepherd_crook_sweep", "shepherd_titanic_charge", "pure_shaper_flock"],
  "npc_dota_hero_slark": ["whale_hunter_knife_toss", "whale_hunter_surge", "whale_hunter_heartstrike", "whale_hunter_deep_rising", "rage_shaper_adrenaline"]
};

InspectHero = function(char) {
  var abilityPreviewPanel, addAbilityPreview, char_name_panel, findSkinTarget, hero_name, i, j, k, len, previewPanel, ref, results;
  if ($("#LockButton").enabled) {
    GameEvents.SendCustomGameEventToServer("SelectShaper", {
      shaper: char
    });
    GameEvents.SendCustomGameEventToServer("SelectSkin", {
      skin: "default"
    });
  }
  $('#CharSelectInspector').RemoveAndDeleteChildren();
  char_name_panel = $.CreatePanel("Label", $('#CharSelectInspector'), "CharSelectLabel");
  char_name_panel.style.width = "100%";
  char_name_panel.style.height = "17%";
  char_name_panel.style.textAlign = "center";
  char_name_panel.style.fontSize = "36px";
  char_name_panel.text = $.Localize(char);
  previewPanel = $.CreatePanel("Panel", $('#CharSelectInspector'), "HeroInspectionScene");
  previewPanel.BLoadLayoutFromString('<root><Panel><DOTAScenePanel style="width: 100%; height: 100%; opacity-mask: url(\'s2r://panorama/images/masks/softedge_box_png.vtex\');" unit="' + char + '"/></Panel></root>', false, false);
  abilityPreviewPanel = $.CreatePanel("Panel", $('#CharSelectInspector'), "AbilityPreviewPanel");
  abilityPreviewPanel.style.width = "100%";
  abilityPreviewPanel.style.height = "13%";
  abilityPreviewPanel.AddClass("flow-right");
  addAbilityPreview = function(index) {
    var ability_holder, ability_image;
    ability_holder = $.CreatePanel("Panel", abilityPreviewPanel, "CharInspectorAbility" + index);
    ability_holder.style.height = "100%";
    ability_holder.style.width = "fill-parent-flow(1)";
    ability_image = $.CreatePanel("Image", ability_holder, "CharInspectorAbilityImage" + index);
    ability_image.style.height = "100%";
    ability_image.style.width = "height-percentage(100%)";
    ability_image.SetImage("file://{images}/custom_game/spellicons/" + shaper_choices_table[char][index] + ".png");
    ability_image.SetPanelEvent('onmouseover', function() {
      return $.DispatchEvent('DOTAShowAbilityTooltip', ability_image, "ability_" + shaper_choices_table[char][index]);
    });
    return ability_image.SetPanelEvent('onmouseout', function() {
      return $.DispatchEvent('DOTAHideAbilityTooltip', ability_image);
    });
  };
  for (i = j = 0; j <= 4; i = ++j) {
    addAbilityPreview(i);
  }
  $("#SkinSelectionTitle").text = "";
  $("#SkinSelectionArea").RemoveAndDeleteChildren();
  findSkinTarget = function(hero_name) {
    var addSkin, k, len, ref, results, skin;
    if (hero_name === char) {
      addSkin = function(skin_name, bypass) {
        var skin_image_panel;
        if (bypass || owned_skins.indexOf(skin_name) >= 0) {
          $("#SkinSelectionTitle").text = "Skins";
          skin_image_panel = $.CreatePanel("Image", $("#SkinSelectionArea"), "SkinSelection" + skin_name);
          skin_image_panel.style.width = "100%";
          skin_image_panel.style.height = "width-percentage(100%)";
          skin_image_panel.style.margin = "4px";
          skin_image_panel.SetImage("file://{images}/heroes/icons/" + skin_name + ".png");
          return skin_image_panel.SetPanelEvent('onactivate', function() {
            var return_name;
            return_name = skin_name;
            if (return_name === hero_name) {
              return_name = "default";
            }
            return GameEvents.SendCustomGameEventToServer("SelectSkin", {
              skin: return_name
            });
          });
        }
      };
      addSkin(hero_name, true);
      ref = skin_map[hero_name];
      results = [];
      for (k = 0, len = ref.length; k < len; k++) {
        skin = ref[k];
        results.push(addSkin(skin, false));
      }
      return results;
    }
  };
  ref = Object.keys(skin_map);
  results = [];
  for (k = 0, len = ref.length; k < len; k++) {
    hero_name = ref[k];
    results.push(findSkinTarget(hero_name));
  }
  return results;
};

BuildSelections = function() {
  var build_char_selection, build_char_selection_row, char, char_area, char_x, char_y, fill_char_selection, index, j, k, len, ref, ref1, results;
  char_area = $("#CharSelectArea");
  char_x = 1;
  char_y = 1;
  build_char_selection_row = function(index) {
    var char_select_row;
    char_select_row = $.CreatePanel("Panel", char_area, "CharSelectAreaRow" + index);
    char_select_row.style.width = "100%";
    char_select_row.style.height = "fill-parent-flow(1)";
    return char_select_row.AddClass("flow-right");
  };
  build_char_selection = function(char) {
    var char_button, char_image, char_panel;
    char_panel = $.CreatePanel("Panel", $("#CharSelectAreaRow" + char_y), "Char" + char);
    char_panel.style.height = "100%";
    char_panel.style.width = "fill-parent-flow(1)";
    char_button = $.CreatePanel("Button", char_panel, "CharButton" + char);
    char_button.AddClass("char-button");
    char_button.style.height = "width-percentage(100%)";
    char_button.style.verticalAlign = "center";
    char_button.AddClass("fill-width");
    char_button.SetPanelEvent('onactivate', function() {
      return InspectHero(char);
    });
    char_image = $.CreatePanel("Image", char_button, "CharImage" + char);
    char_image.AddClass("fill");
    char_image.SetScaling("stretch-to-fit-preserve-aspect");
    char_image.SetImage("file://{images}/heroes/icons/" + char + ".png");
    char_x = char_x + 1;
    if (char_x > 6) {
      char_y++;
      char_x = 1;
      return build_char_selection_row(char_y);
    }
  };
  build_char_selection_row(1);
  ref = Object.keys(shaper_choices_table);
  for (j = 0, len = ref.length; j < len; j++) {
    char = ref[j];
    build_char_selection(char);
  }
  fill_char_selection = function(index) {
    var char_panel;
    char_panel = $.CreatePanel("Panel", $("#CharSelectAreaRow" + char_y), "CharSpacer" + index);
    char_panel.style.height = "100%";
    return char_panel.style.width = "fill-parent-flow(1)";
  };
  results = [];
  for (index = k = ref1 = char_x; ref1 <= 6 ? k <= 6 : k >= 6; index = ref1 <= 6 ? ++k : --k) {
    results.push(fill_char_selection(index));
  }
  return results;
};

BuildSelections();

LockSelections = function() {
  $("#LockButton").enabled = false;
  $("#LockButtonLabel").text = "Locked In";
  return GameEvents.SendCustomGameEventToServer("LockSelections", {});
};

RoleMouseOver = function(role) {
  var desc;
  desc = $.Localize("role_description_" + role.toLowerCase());
  $("#RoleInfoInspector").style.backgroundColor = "#000000CC";
  return $("#RoleInfoLabel").text = desc;
};

RoleMouseOut = function(role) {
  $("#RoleInfoInspector").style.backgroundColor = "#00000000";
  return $("#RoleInfoLabel").text = "";
};

RoleSelect = function(role) {
  if ($("#LockButton").enabled) {
    return GameEvents.SendCustomGameEventToServer("SelectRole", {
      role: role
    });
  }
};

OnTimeUpdate = function(data) {
  $("#HeroSelectionRoot").style.width = "100%";
  return $("#SelectTimerLabel").text = data.time + " Seconds Left.";
};

OnTimeOver = function(data) {
  return $.GetContextPanel().style.opacity = 0;
};

OnSelectShaper = function(data) {
  return $('#' + playerIDToTeam[data.pid] + "PlayerPanelShaperImage" + playerIDToIndex[data.pid]).SetImage("file://{images}/heroes/icons/" + data.shaper + ".png");
};

OnSelectRole = function(data) {
  return $('#' + playerIDToTeam[data.pid] + "PlayerPanelRoleImage" + playerIDToIndex[data.pid]).SetImage("file://{images}/custom_game/roles/role_" + data.role.toLowerCase() + ".png");
};

OnChatSubmitted = function() {
  GameEvents.SendCustomGameEventToServer("SpiritgateChat", {
    text: $("#ChatEntry").text
  });
  return $("#ChatEntry").text = "";
};

OnSpiritgateChat = function(data) {
  if(data.text.length > 0) {
    var chat_message_panel, chat_panel;
    chat_panel = $("#BottomPanelChatArea");
    chat_message_panel = $.CreatePanel("Label", chat_panel, "ChatMessage");
    chat_message_panel.style.fontSize = "20px";
    chat_message_panel.text = Players.GetPlayerName(data.pid) + ":" + data.text;
    chat_panel.ScrollToBottom()
  }
};

GameEvents.Subscribe("picking_time_update", OnTimeUpdate);

GameEvents.Subscribe("SelectShaper", OnSelectShaper);

GameEvents.Subscribe("SelectRole", OnSelectRole);

GameEvents.Subscribe("picking_time_over", OnTimeOver);

GameEvents.Subscribe("SpiritgateChat", OnSpiritgateChat);
