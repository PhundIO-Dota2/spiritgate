var AbilityMouseExit, AbilityMouseOver, BuildAbilityBar, LevelupSpell, SpellBook, Update, abilities, ability_hotkeys, consumable, is_consumable_press, is_spell1_press, is_spell2_press, is_spell3_press, latest_abilities, resources, spells, total_buffs;

abilities = ["AbilityQ", "AbilityW", "AbilityE", "AbilityR", "AbilitySpell1", "AbilitySpell2", "AbilitySpell3", "AbilityConsumable", "AbilityRecall", "AbilityPlaceWard"];

var health_costs = {}

ability_hotkeys = ["Q", "W", "E", "R", "1", "2", "3", "4", "B", "F"];

resources = {
  "npc_dota_hero_bloodseeker": {
    color: "#FF0000",
    modifier: "modifier_rage_stack",
    max_resource: 100,
    resource_name: "Rage",
    show_resource_text: true
  },
  "npc_dota_hero_queenofpain": {
    disable_abilities: {
      w: ["modifier_purifier_blood_orb", "minimum", 1]
    }
  },
  "npc_dota_hero_pudge": {
    color: "#ffd21f",
    mana: true,
    resource_name: "Focus",
    show_resource_text: true
  },
  "npc_dota_hero_legion_commander": {
    color: "#ffd21f",
    mana: true,
    resource_name: "Focus",
    show_resource_text: true
  },
  "npc_dota_hero_earth_spirit": {
    color: "#feb911",
    resource_name: "Inspiration",
    max_resource: 5,
    modifier: "modifier_inspiration",
    show_resource_text: true
  },
  "npc_dota_hero_naga_siren": {
    color: "#3e8dea",
    mana: true,
    resource_name: "Mana",
    show_resource_text: true
  },
  "npc_dota_hero_crystal_maiden": {
    color: "#e9f3ff",
    modifier: "modifier_frost",
    max_resource: 10,
    resource_name: "Frost",
    show_resource_text: true,
    disable_abilities: {
      q: ["modifier_frost", "minimum", 1],
      w: ["modifier_ice_shard", "minimum", 1]
    }
  },
  "npc_dota_hero_slark": {
    color: "#FF0000",
    modifier: "modifier_rage_adrenaline_stack",
    max_resource: 100,
    resource_name: "Rage",
    show_resource_text: true,
    disable_abilities: {
      q: ["modifier_whale_hunter_knives", "minimum", 1]
    }
  },
};

AbilityMouseOver = function(index) {
  var local_entity, local_pid;
  local_pid = Players.GetLocalPlayer();
  local_entity = Players.GetPlayerHeroEntityIndex(local_pid);
  if (index <= 3) {
    return $.DispatchEvent('DOTAShowAbilityTooltipForEntityIndex', $("#" + abilities[index]), Abilities.GetAbilityName(Entities.GetAbility(local_entity, index + (index == 3 ? 3 : 0))), local_entity);
  } else if (index <= 6) {
    return $.DispatchEvent('DOTAShowAbilityTooltipForEntityIndex', $("#" + abilities[index]), Abilities.GetAbilityName(spells[index - 4]), local_entity);
  } else if (index === 7) {
    return $.DispatchEvent('DOTAShowAbilityTooltipForEntityIndex', $("#" + abilities[index]), Abilities.GetAbilityName(consumable), local_entity);
  } else if (index === 8) {
    return $.DispatchEvent('DOTAShowAbilityTooltipForEntityIndex', $("#" + abilities[index]), Abilities.GetAbilityName(Entities.GetAbilityByName(local_entity, "ability_universal_recall")), local_entity);
  } else if (index === 9) {
    return $.DispatchEvent('DOTAShowAbilityTooltipForEntityIndex', $("#" + abilities[index]), Abilities.GetAbilityName(Entities.GetAbilityByName(local_entity, "ability_universal_ability_ward")), local_entity);
  }
};

SpellMouseOver = function(spell) {
  var local_entity, local_pid;
  local_pid = Players.GetLocalPlayer();
  local_entity = Players.GetPlayerHeroEntityIndex(local_pid);
  return $.DispatchEvent('DOTAShowAbilityTooltipForEntityIndex', $("#" + spell), "spell_" + spell, local_entity);
}

SpellMouseOut = function(spell) {
  return $.DispatchEvent('DOTAHideAbilityTooltip', $("#" + spell));
};

spell_points = 0
spell_index = 0 //Current spell to make points availible for

owned_spells = []

SelectSpell = function(spell) {
  if(owned_spells.indexOf(spell) >= 0) {
    return
  }
  owned_spells.push(spell)

  var padlock_panel = $.CreatePanel("Image", $("#" + spell).GetParent(), spell + "Lock")
  padlock_panel.SetImage("file://{images}/custom_game/hud/padlock.png")
  padlock_panel.AddClass("fill")

  spell_points -= 1
  if(spell_points == 0) {
    $("#SpellBook").style.opacity = 0;
  }
  GameEvents.SendCustomGameEventToServer("SelectSpell", {
    spell: spell
  });
}

GameEvents.Subscribe("add_spell_point", function() {
  spell_points = spell_points + 1
  $("#SpellBook").style.opacity = 1;
});

AbilityMouseExit = function(index) {
  return $.DispatchEvent('DOTAHideAbilityTooltip', $("#" + abilities[index]));
};

latest_abilities = {};

spells = [];

consumable = null;

BuildAbilityBar = function() {
  var ability_id, build_ability, i, j, k, local_entity, local_pid, results, try_fill_spell_slot;
  local_pid = Players.GetLocalPlayer();
  local_entity = Players.GetPlayerHeroEntityIndex(local_pid);
  spells = [];
  consumable = null;
  try_fill_spell_slot = function(i) {
    var abil;
    abil = Entities.GetAbility(local_entity, i);
    if (abil !== -1 && Abilities.GetAbilityName(abil).substring(0, 6) === "spell_") {
      spells[spells.length] = abil;
    }
    if (abil !== -1 && Abilities.GetAbilityName(abil).substring(0, 11) === "consumable_") {
      return consumable = abil;
    }
  };
  for (i = j = 0; j <= 16; i = ++j) {
    try_fill_spell_slot(i);
  }
  build_ability = function(ability_id) {
    var ability, abilityImage, index, k, l, local_ability, local_cooldown_label, local_cooldown_panel, local_hotkey_label, local_level_indicator, makeLevelIndicator, results, results1;
    ability = $("#" + abilities[ability_id]);
    ability.RemoveAndDeleteChildren();
    abilityImage = $.CreatePanel("Image", ability, abilities[ability_id] + "Image");
    abilityImage.AddClass("ability-image");
    local_ability = Entities.GetAbility(local_entity, ability_id + (ability_id == 3 ? 3 : 0));
    if (ability_id <= 3) {
      abilityImage.SetImage("file://{images}/custom_game/spellicons/" + Abilities.GetAbilityTextureName(local_ability) + ".png");
    }
    local_hotkey_label = $.CreatePanel("Label", ability, abilities[ability_id] + "HotkeyLabel");
    local_hotkey_label.text = "   " + ability_hotkeys[ability_id];
    local_hotkey_label.AddClass("hotkey-label");
    local_cooldown_panel = $.CreatePanel("Panel", abilityImage, abilities[ability_id] + "CooldownPanel");
    local_cooldown_panel.AddClass("cooldown-panel");
    local_cooldown_label = $.CreatePanel("Label", abilityImage, abilities[ability_id] + "CooldownLabel");
    local_cooldown_label.text = "0";
    local_cooldown_label.AddClass("cooldown-label");
    local_cooldown_label.style.opacity = 0;
    if (ability_id <= 3) {
      local_level_indicator = $.CreatePanel("Panel", abilityImage, abilities[ability_id] + "LevelIndicator");
      local_level_indicator.AddClass("level-indicator");
      local_level_indicator.AddClass("flow-down");
      makeLevelIndicator = function(index) {
        var local_level_indicator_tick;
        local_level_indicator_tick = $.CreatePanel("Panel", local_level_indicator, "Ability" + ability_id + "Indicator" + index);
        return local_level_indicator_tick.AddClass("level-indicator-tick");
      };
      if (ability_id <= 2) {
        results = [];
        for (index = k = 1; k <= 5; index = ++k) {
          results.push(makeLevelIndicator(index));
        }
        return results;
      } else {
        results1 = [];
        for (index = l = 1; l <= 3; index = ++l) {
          results1.push(makeLevelIndicator(index));
        }
        return results1;
      }
    } else if (ability_id <= 6) {
      if (spells.length > ability_id - 4) {
        return abilityImage.SetImage("file://{images}/custom_game/spellicons/" + Abilities.GetAbilityName(spells[ability_id - 4]) + ".png");
      } else {
        return abilityImage.SetImage("file://{images}/custom_game/hud/spell_unlearned.png");
      }
    } else if (ability_id === 7) {
      if (consumable !== null) {
        return abilityImage.SetImage("file://{images}/custom_game/consumables/" + Abilities.GetAbilityName(consumable) + ".png");
      } else {
        return abilityImage.SetImage("file://{images}/custom_game/hud/spell_unlearned.png");
      }
    } else if (ability_id === 8) {
      return abilityImage.SetImage("file://{images}/custom_game/spellicons/universal_recall.png");
    } else if (ability_id === 9) {
      return abilityImage.SetImage("file://{images}/custom_game/hud/ward.png");
    }
  };
  results = [];
  for (ability_id = k = 0; k <= 9; ability_id = ++k) {
    results.push(build_ability(ability_id));
  }
  return results;
};

LevelupSpell = function(index) {
  var local_ability, local_entity, local_pid;
  local_pid = Players.GetLocalPlayer();
  local_entity = Players.GetPlayerHeroEntityIndex(local_pid);
  local_ability = Entities.GetAbility(local_entity, index + (index == 3 ? 3 : 0));
  if (Abilities.CanAbilityBeUpgraded(local_ability) === AbilityLearnResult_t.ABILITY_CAN_BE_UPGRADED) {
    return GameEvents.SendCustomGameEventToServer("LevelAbility", {
      index: index + (index == 3 ? 3 : 0)
    });
  }
};

total_buffs = 0;

var no_cast_reasons = {}

Update = function() {
  var UpdateAbilityLevel, ability_id, ability_index, buff_index, clear_buff, do_buff, find_resource_buff, hiddens_found, i, index, j, k, l, local_entity, local_pid, m, n, new_latest_abilities, o, p, progress_bar, q, r, rebuilt, ref, ref1, ref2, ref3, ref4, resource, resource_amount, resource_width, try_rebuild, ui_buff_index, update_ability_levelup, update_cooldown;
  local_pid = Players.GetLocalPlayer();
  local_entity = Players.GetPlayerHeroEntityIndex(local_pid);
  resource = resources[Entities.GetUnitName(local_entity)];
  new_latest_abilities = [];
  for (i = j = 0; j <= 20; i = ++j) {
    new_latest_abilities[i] = Entities.GetAbility(local_entity, i);
  }
  rebuilt = false;
  try_rebuild = function(i) {
    if (!rebuilt && new_latest_abilities[i] !== latest_abilities[i]) {
      latest_abilities = new_latest_abilities;
      BuildAbilityBar();
      return rebuilt = true;
    }
  };
  for (i = k = 0; k <= 20; i = ++k) {
    try_rebuild(i);
  }
  castable_abilities = {}
  update_cooldown = function(local_ability, index) {
    var cooldown_label, cooldown_panel, displayNum, find_resource_amount, full_cooldown_not_enough_resources, resource_amount;
    if (local_ability === -1 && local_ability !== void 0) {
      return;
    }
    cooldown_label = $("#" + abilities[index] + "CooldownLabel");
    cooldown_panel = $("#" + abilities[index] + "CooldownPanel");
    full_cooldown_not_enough_resources = false;
    find_resource_amount = function(buffname) {
      var buff_index, find_resource_buff, l, ref, resource_amount;
      resource_amount = 0;
      find_resource_buff = function(buff_index, buffname) {
        var buff;
        buff = Entities.GetBuff(local_entity, buff_index);
        if (Buffs.GetName(local_entity, buff) === buffname) {
          return resource_amount += Buffs.GetStackCount(local_entity, buff);
        }
      };
      for (buff_index = l = 0, ref = Entities.GetNumBuffs(local_entity); 0 <= ref ? l <= ref : l >= ref; buff_index = 0 <= ref ? ++l : --l) {
        find_resource_buff(buff_index, buffname);
      }
      return resource_amount;
    };
    if (resource !== void 0) {
      if (index === 0 && resource.disable_abilities !== void 0 && resource.disable_abilities.q !== void 0) {
        resource_amount = find_resource_amount(resource.disable_abilities.q[0]);
        if (resource.disable_abilities.q[1] === "minimum" && resource_amount < resource.disable_abilities.q[2]) {
          full_cooldown_not_enough_resources = true;
        }
      }
      if (index === 1 && resource.disable_abilities !== void 0 && resource.disable_abilities.w !== void 0) {
        resource_amount = find_resource_amount(resource.disable_abilities.w[0]);
        if (resource.disable_abilities.w[1] === "minimum" && resource_amount < resource.disable_abilities.w[2]) {
          full_cooldown_not_enough_resources = true;
        }
      }
      if (index === 2 && resource.disable_abilities !== void 0 && resource.disable_abilities.e !== void 0) {
        resource_amount = find_resource_amount(resource.disable_abilities.e[0]);
        if (resource.disable_abilities.e[1] === "minimum" && resource_amount < resource.disable_abilities.e[2]) {
          full_cooldown_not_enough_resources = true;
        }
      }
      if (index === 3 && resource.disable_abilities !== void 0 && resource.disable_abilities.r !== void 0) {
        resource_amount = find_resource_amount(resource.disable_abilities.r[0]);
        if (resource.disable_abilities.r[1] === "minimum" && resource_amount < resource.disable_abilities.r[2]) {
          full_cooldown_not_enough_resources = true;
        }
      }
    }
    no_cast_reasons[index] = null
    if ((full_cooldown_not_enough_resources || Abilities.GetManaCost(local_ability) > Entities.GetMana(local_entity) || Entities.GetHealth(local_entity) < health_costs[index]) && Abilities.GetLevel(local_ability) > 0) {
      cooldown_panel.style.width = "100%";
      cooldown_label.text = "x";
      cooldown_label.style.color = "red";
      cooldown_label.style.opacity = 0.75;
      if(Abilities.GetManaCost(local_ability) > Entities.GetMana(local_entity)) {
        no_cast_reasons[index] = "error_not_enough_mana"
      }
      if(full_cooldown_not_enough_resources) {
        no_cast_reasons[index] = "error_not_enough_resource"
      }
      if(Entities.GetHealth(local_entity) < health_costs[index]) {
        no_cast_reasons[index] = "error_not_enough_health"
      }
    } else if (Abilities.GetCooldown(local_ability) > 0) {
      cooldown_panel.style.width = Abilities.GetCooldownTimeRemaining(local_ability) / Abilities.GetCooldown(local_ability) * 100 + "%";
    } else if (Abilities.GetLevel(local_ability) !== 0) {
      cooldown_panel.style.width = "0%";
    } else {
      cooldown_panel.style.width = "100%";
    }
    if (Abilities.GetCooldownTimeRemaining(local_ability) > 0) {
      displayNum = Math.round(Abilities.GetCooldownTimeRemaining(local_ability) * 10) / 10;
      if (displayNum === Math.round(displayNum) && displayNum < 10) {
        displayNum = displayNum + ".0";
      } else if (displayNum > 10) {
        displayNum = Math.round(displayNum);
      }
      cooldown_label.text = displayNum;
      cooldown_label.style.color = "white";
      cooldown_label.style.opacity = 1;
    } else if(!(full_cooldown_not_enough_resources || Abilities.GetManaCost(local_ability) > Entities.GetMana(local_entity) || Entities.GetHealth(local_entity) < health_costs[index])) {
      cooldown_label.style.opacity = 0;
    }
  };
  for (index = l = 0; l <= 3; index = ++l) {
    update_cooldown(Entities.GetAbility(local_entity, index + (index == 3 ? 3 : 0)), index);
  }
  update_cooldown(Entities.GetAbility(local_entity, 6), 6);
  if (spells.length > 0) {
    for (index = m = 0, ref = spells.length - 1; 0 <= ref ? m <= ref : m >= ref; index = 0 <= ref ? ++m : --m) {
      update_cooldown(spells[index], index + 4);
    }
  }
  if (consumable !== null) {
    update_cooldown(consumable, 7);
  }
  update_cooldown(Entities.GetAbilityByName(local_entity, "ability_universal_recall"), 8);
  update_cooldown(Entities.GetAbilityByName(local_entity, "ability_universal_ability_ward"), 9);
  $("#HealthBarProgress").style.width = Entities.GetHealthPercent(local_entity) + "%";
  $("#AbilityBarLevelUps").style.opacity = 1;
  update_ability_levelup = function(ability_id) {
    var ability, levelup_pane;
    ability = Entities.GetAbility(local_entity, ability_id + (ability_id == 3 ? 3 : 0));
    levelup_pane = $("#" + abilities[ability_id] + "levelup");
    if (ability_id < 4 && Entities.GetAbilityPoints(local_entity) > 0 && Abilities.CanAbilityBeUpgraded(ability) === AbilityLearnResult_t.ABILITY_CAN_BE_UPGRADED) {
      levelup_pane.enabled = true;
      levelup_pane.RemoveClass("disabled-levelup-pane");
    } else {
      levelup_pane.AddClass("disabled-levelup-pane");
    }
  };
  for (ability_id = n = 0; n <= 6; ability_id = ++n) {
    update_ability_levelup(ability_id);
  }
  UpdateAbilityLevel = function(ability_index) {
    var UpdateAbilityIndicator, indicator_index, o, p, results, results1;
    UpdateAbilityIndicator = function(indicator_index, max) {
      var indicator;
      indicator = $("#Ability" + ability_index + "Indicator" + indicator_index);
      if (Abilities.GetLevel(Entities.GetAbility(local_entity, ability_index + (ability_index == 3 ? 3 : 0))) > max - indicator_index) {
        return indicator.AddClass("level-indicator-tick-active");
      } else {
        return indicator.RemoveClass("level-indicator-tick-active");
      }
    };
    if (ability_index <= 2) {
      results = [];
      for (indicator_index = o = 1; o <= 5; indicator_index = ++o) {
        results.push(UpdateAbilityIndicator(indicator_index, 5));
      }
      return results;
    } else {
      results1 = [];
      for (indicator_index = p = 1; p <= 3; indicator_index = ++p) {
        results1.push(UpdateAbilityIndicator(indicator_index, 3));
      }
      return results1;
    }
  };
  for (ability_index = o = 0; o <= 3; ability_index = ++o) {
    UpdateAbilityLevel(ability_index);
  }
  $("#StatsVim").text = "Vim: " + Players.GetGold(local_pid);
  if (Entities.GetNeededXPToLevel(local_entity) !== 0) {
    $("#StatsExp").text = "Exp: " + Entities.GetCurrentXP(local_entity) + "/" + Entities.GetNeededXPToLevel(local_entity);
  } else {
    $("#StatsExp").text = "Exp: ~/~";
  }
  hiddens_found = 0;
  do_buff = function(buff_index) {
    var buff, buff_stacks, local_buff_image, local_buff_image_border, local_buff_panel, local_buff_stacks, local_buff_timeout_panel, texture_name, ui_buff_index, width_percent;
    buff = Entities.GetBuff(local_entity, buff_index);
    texture_name = Buffs.GetTexture(local_entity, buff);
    if (Buffs.IsHidden(local_entity, buff)) {
      hiddens_found = hiddens_found + 1;
      return;
    }
    ui_buff_index = buff_index - hiddens_found;
    total_buffs = Math.max(total_buffs, ui_buff_index);
    local_buff_image = null;
    local_buff_image_border = null;
    local_buff_stacks = null;
    local_buff_timeout_panel = null;
    if ($("#Buff" + ui_buff_index) === null) {
      local_buff_panel = $.CreatePanel("Panel", $("#BuffBar"), "Buff" + ui_buff_index);
      local_buff_panel.AddClass("buff");
      local_buff_image = $.CreatePanel("Image", local_buff_panel, "Buff" + ui_buff_index + "Image");
      local_buff_image_border = $.CreatePanel("Image", local_buff_panel, "Buff" + ui_buff_index + "Border");
      local_buff_stacks = $.CreatePanel("Label", local_buff_panel, "Buff" + ui_buff_index + "Stacks");
      local_buff_stacks.AddClass("buff-stacks");
      local_buff_timeout_panel = $.CreatePanel("Panel", local_buff_panel, "Buff" + ui_buff_index + "Timeout");
      local_buff_timeout_panel.AddClass("cooldown-panel");
    } else {
      local_buff_image = $("#Buff" + ui_buff_index + "Image");
      local_buff_image_border = $("#Buff" + ui_buff_index + "Border");
      local_buff_stacks = $("#Buff" + ui_buff_index + "Stacks");
      local_buff_timeout_panel = $("#Buff" + ui_buff_index + "Timeout");
    }
    $("#Buff" + ui_buff_index).style.opacity = 1;
    if (texture_name.indexOf("item_") === -1) {
      local_buff_image.SetImage("file://{images}/custom_game/spellicons/" + texture_name + ".png");
    } else {
      local_buff_image.SetImage("file://{images}/custom_game/items/square_items/" + texture_name.replace("item_", "") + ".png");
    }
    if (Buffs.IsDebuff(local_entity, buff)) {
      local_buff_image_border.SetImage("file://{images}/custom_game/hud/buff_bad.png");
    } else {
      local_buff_image_border.SetImage("file://{images}/custom_game/hud/buff_good.png");
    }
    buff_stacks = Buffs.GetStackCount(local_entity, buff);
    if (buff_stacks > 0) {
      local_buff_stacks.text = "" + buff_stacks;
    } else {
      local_buff_stacks.text = "";
    }
    width_percent = Buffs.GetRemainingTime(local_entity, buff) / Buffs.GetDuration(local_entity, buff) * 100;
    if (Buffs.GetDuration(local_entity, buff) === -1 || Buffs.GetDuration(local_entity, buff) === 0 || width_percent === NaN) {
      width_percent = 100;
    }
    local_buff_timeout_panel.style.width = (100 - width_percent) + "%";
    $("#Buff" + ui_buff_index).SetPanelEvent('onmouseover', function() {
      return $.DispatchEvent('DOTAShowBuffTooltip', $("#Buff" + ui_buff_index), local_entity, buff, false);
    });
    return $("#Buff" + ui_buff_index).SetPanelEvent('onmouseout', function() {
      return $.DispatchEvent('DOTAHideBuffTooltip', $("#Buff" + ui_buff_index));
    });
  };
  for (buff_index = p = 0, ref1 = Entities.GetNumBuffs(local_entity); 0 <= ref1 ? p <= ref1 : p >= ref1; buff_index = 0 <= ref1 ? ++p : --p) {
    do_buff(buff_index);
  }
  clear_buff = function(ui_buff_index) {
    if ($("#Buff" + ui_buff_index) !== null) {
      return $("#Buff" + ui_buff_index).style.opacity = 0;
    }
  };
  for (ui_buff_index = q = ref2 = Entities.GetNumBuffs(local_entity) - hiddens_found, ref3 = total_buffs; ref2 <= ref3 ? q <= ref3 : q >= ref3; ui_buff_index = ref2 <= ref3 ? ++q : --q) {
    clear_buff(ui_buff_index);
  }
  $("#LevelLabel").text = Entities.GetLevel(local_entity);
  $("#HealthBarLabel").text = "Health:" + Entities.GetHealth(local_entity) + "/" + Entities.GetMaxHealth(local_entity) + "(+" + Entities.GetHealthThinkRegen(local_entity) + ")";
  progress_bar = $("#ResourceBarProgress");
  if (progress_bar !== null) {
    if (resource !== void 0) {
      if (resource.color != null) {
        progress_bar.style.backgroundColor = resource.color;
        resource_width = 1;
        resource_amount = 0;
        if (resource.modifier !== null) {
          resource_amount = 0;
          find_resource_buff = function(buff_index) {
            var buff;
            buff = Entities.GetBuff(local_entity, buff_index);
            if (Buffs.GetName(local_entity, buff) === resource.modifier) {
              return resource_amount += Buffs.GetStackCount(local_entity, buff);
            }
          };
          for (buff_index = r = 0, ref4 = Entities.GetNumBuffs(local_entity); 0 <= ref4 ? r <= ref4 : r >= ref4; buff_index = 0 <= ref4 ? ++r : --r) {
            find_resource_buff(buff_index);
          }
          resource_width = resource_amount / resource.max_resource;
        }
        if (resource.mana === true) {
          resource_width = Entities.GetMana(local_entity) / Entities.GetMaxMana(local_entity);
          resource.max_resource = Entities.GetMaxMana(local_entity);
          resource_amount = Entities.GetMana(local_entity);
        }
        progress_bar.style.width = resource_width * 100 + "%";
        if (resource.show_resource_text && $("#ResourceBarLabel") !== null) {
          $("#ResourceBarLabel").text = resource.resource_name + ": " + resource_amount + "/" + resource.max_resource;
        }
      }
    } else {
      progress_bar.style.width = "0%";
      progress_bar.style.backgroundColor = "#000000";
    }
  }
  return $.Schedule(1 / 30, Update);
};

Update();

is_spell1_press = true;

is_spell2_press = true;

is_spell3_press = true;

Game.SpiritgateSpell1 = function() {
  local_pid = Players.GetLocalPlayer();
  local_entity = Players.GetPlayerHeroEntityIndex(local_pid);
  for (var i = 0; i < 16; i++) {
    if(spells[0] == Entities.GetAbility(local_entity, i)) {
      CastAbility(i)
    }
  }
};

Game.SpiritgateSpell2 = function() {
  local_pid = Players.GetLocalPlayer();
  local_entity = Players.GetPlayerHeroEntityIndex(local_pid);
  for (var i = 0; i < 16; i++) {
    if(spells[1] == Entities.GetAbility(local_entity, i)) {
      CastAbility(i)
    }
  }
};

Game.SpiritgateSpell3 = function() {
  local_pid = Players.GetLocalPlayer();
  local_entity = Players.GetPlayerHeroEntityIndex(local_pid);
  for (var i = 0; i < 16; i++) {
    if(spells[2] == Entities.GetAbility(local_entity, i)) {
      CastAbility(i)
    }
  }
  /*

  var local_entity, local_pid, pos;
  if (spells.length > 2) {
    local_pid = Players.GetLocalPlayer();
    local_entity = Players.GetPlayerHeroEntityIndex(local_pid);
    if (is_spell3_press) {
      is_spell3_press = false;
      GameUI.SelectUnit(local_entity, false)
      Abilities.ExecuteAbility(spells[2], local_entity, false)
    } else {
      return is_spell3_press = true;
    }
  }

  */
};

Game.SpiritgateConsumable = function() {
  CastAbility(9)
};
Game.SpiritgateAbilityWard = function() {
  CastAbility(4)
};

Game.SpiritgateRecall = function() {
  local_pid = Players.GetLocalPlayer();
  local_entity = Players.GetPlayerHeroEntityIndex(local_pid);
  local_ability = Entities.GetAbilityByName(local_entity, "ability_universal_recall")
  CastAbilityByID(local_ability)
};

function CastAbilityByID(local_ability) {
  local_pid = Players.GetLocalPlayer();
  local_entity = Players.GetPlayerHeroEntityIndex(local_pid);
  if(!GameUI.IsControlDown() ) {
    if(Abilities.GetCooldownTimeRemaining(local_ability) > 0) {
      ShowScreenNotification("error_cooldown")
      return
    }
    if(Abilities.GetLevel(local_ability) == 0) {
      ShowScreenNotification("error_unlearned")
      return
    }
    //if(no_cast_reasons[index] != null) {
    //  ShowScreenNotification(no_cast_reasons[index])
    //  return
    //}
  } else {
    if(Entities.GetAbilityPoints(local_entity) == 0) {
      ShowScreenNotification("error_no_skill_points")
      return
    } else {
      Abilities.AttemptToUpgrade(local_ability)
      return
    }
  }
  if(Abilities.AbilityReady(local_ability) > 0) {
    ShowScreenNotification("error_cooldown")
    return
  }
  Abilities.ExecuteAbility(local_ability, local_entity, false);
}

function CastAbility(index) {
  local_pid = Players.GetLocalPlayer();
  local_entity = Players.GetPlayerHeroEntityIndex(local_pid);
  local_ability = Entities.GetAbility(local_entity, index)

  CastAbilityByID(local_ability)
}

Game.SpiritgateAbilityQ = function() {
  CastAbility(0)
}
Game.SpiritgateAbilityW = function() {
  CastAbility(1)
}
Game.SpiritgateAbilityE = function() {
  CastAbility(2)
}
Game.SpiritgateAbilityR = function() {
  CastAbility(6)
}

function SetHealthCost(data) {
  health_costs[data.index] = data.cost
}

GameEvents.Subscribe("health_cost_set", SetHealthCost);