var HideShopOnly, ItemPanelInventoryMouseExit, ItemPanelInventoryMouseOver, ItemPanelMouseExit, ItemPanelMouseOver, ItemPanelOnActivate, ItemPanelOnActivateSell, OnUpdateInventory, OnUpdateStore, ShowItems, ShowShop, costs, double_click_tester, is_shop_active, items;

is_shop_active = true;

double_click_tester = false;

ShowShop = function() {
  if ($("#Shop").BHasClass("is-not-visible")) {
    $("#Shop").RemoveClass("is-not-visible");
    $("#Shop").AddClass("is-visible");
    return $("#ShopContainer").hittest = true;
  } else {
    $("#Shop").RemoveClass("is-visible");
    $("#Shop").AddClass("is-not-visible");
    return $("#ShopContainer").hittest = false;
  }
};

HideShopOnly = function() {
  if ($("#Shop").BHasClass("is-visible")) {
    $("#Shop").RemoveClass("is-visible");
    $("#Shop").AddClass("is-not-visible");
    return $("#ShopContainer").hittest = false;
  }
};

Game.SpiritgateShop = function() {
  ShowShop()
};
items = {
  Life: ["Vigor", "Purity", "Pride", "Growth", ""],
  Resilience: ["Form", "Integrity", "Discipline", "Resolve", ""],
  Will: ["Conviction", "Balance", "Freedom", "Resolve", ""],
  Power: ["Might", "Command", "Aggression", "Control", "Force"],
  Time: ["Motion", "Abolition", "Inspiration", "Clarity", "Energy"],
  Hunger: ["Desire", "Consumption", "", "", ""],
  Vigor: ["Prosperity", "Defiance", "Rampancy", ""],
  Purity: ["Harmony", "Devotion", "Pestilence", ""],
  Pride: ["Vengeance", "Glory", "", ""],
  Growth: ["Rebirth", "Creation", "Vibrance", ""],
  Form: ["Adamance", "Preservation", "", ""],
  Integrity: ["Order", "", "", ""],
  Discipline: ["Equilibrium", "Subjugation", "", ""],
  Resolve: ["Empathy", "Hope", "", ""],
  Conviction: ["Faith", "Retribution", "", ""],
  Balance: ["Betrayal", "Oppression", "Valor", ""],
  Freedom: ["Stability", "Momentum", "", ""],
  Might: ["Strife", "Decay", "", ""],
  Command: ["Supremacy", "Wisdom", "Justice", ""],
  Aggression: ["Judgement", "Rage", "Destruction", ""],
  Control: ["Inevitability", "Pursuit", "", ""],
  Force: ["Hostility", "Pain", "Dominance", "Divinity"],
  Motion: ["Fluidity", "Influence", "Impulse", ""],
  Abolition: ["Conquest", "Ruin", "Finesse", ""],
  Inspiration: ["Corruption", "Duress", "Furor", "Grace"],
  Clarity: ["Fate", "Insight", "Zeal", ""],
  Energy: ["Potency", "Chaos", "Resonance", ""],
  Desire: ["Passion", "Ambition", "", ""],
  Consumption: ["Voracity", "Assimilation", "", ""]
};

costs = {
  "Life": 420,
  "Resilience": 380,
  "Will": 340,
  "Power": 380,
  "Time": 420,
  "Hunger": 460,
  "Vigor": 900,
  "Purity": 1200,
  "Pride": 1500,
  "Growth": 1500,
  "Resolve": 1160,
  "Discipline": 1500,
  "Form": 1500,
  "Integrity": 900,
  "Conviction": 900,
  "Freedom": 1200,
  "Balance": 1500,
  "Might": 900,
  "Control": 1200,
  "Force": 1500,
  "Aggression": 1500,
  "Command": 1200,
  "Motion": 900,
  "Energy": 1460,
  "Inspiration": 1080,
  "Clarity": 860,
  "Abolition": 1460,
  "Desire": 1240,
  "Consumption": 1540,
  "Vengeance": 3000,
  "Glory": 3000,
  "Pestilence": 3050,
  "Devotion": 3050,
  "Harmony": 3000,
  "Prosperity": 3300,
  "Rampancy": 2400,
  "Defiance": 2400,
  "Rebirth": 3000,
  "Vibrance": 2480,
  "Creation": 2215,
  "Empathy": 2760,
  "Hope": 2760,
  "Subjugation": 3000,
  "Equilibrium": 3000,
  "Preservation": 3000,
  "Adamance": 3000,
  "Order": 1700,
  "Retribution": 2200,
  "Faith": 2290,
  "Stability": 2665,
  "Oppression": 2945,
  "Valor": 3000,
  "Betrayal": 3000,
  "Strife": 3000,
  "Decay": 2715,
  "Pursuit": 2665,
  "Inevitability": 2875,
  "Pain": 2915,
  "Divinity": 3000,
  "Dominance": 3515,
  "Hostility": 2920,
  "Rage": 3000,
  "Destruction": 3000,
  "Judgement": 3000,
  "Supremacy": 3000,
  "Wisdom": 3000,
  "Justice": 3000,
  "Fluidity": 2465,
  "Influence": 2645,
  "Impulse": 3070,
  "Conquest": 3000,
  "Ruin": 3000,
  "Finesse": 3000,
  "Corruption": 2335,
  "Furor": 3000,
  "Grace": 2400,
  "Zeal": 2950,
  "Fate": 2790,
  "Insight": 3000,
  "Duress": 2700,
  "Potency": 3000,
  "Chaos": 3000,
  "Resonance": 3000,
  "Passion": 2915,
  "Ambition": 2700,
  "Voracity": 3000,
  "Assimilation": 3000,
  "Momentum": 2750
};

ItemPanelMouseOver = function(item_name) {
  var real_name;
  real_name = "item_" + item_name.replace("Inventory", "").toLowerCase();
  return $.DispatchEvent('DOTAShowAbilityTooltip', $("#Item" + item_name + "Panel"), real_name);
};

ItemPanelMouseExit = function(item_name) {
  return $.DispatchEvent('DOTAHideAbilityTooltip', $("#Item" + item_name + "Panel"));
};

ItemPanelOnActivateSell = function(item_index) {
  var check_item_built_from, i, item, item_built_from, item_built_from_t1, item_built_from_t2, item_friendly_name, item_name, item_store_index, j, k, len, len1, len2, local_entity, local_pid, ref, ref1, ref2, tier;
  local_pid = Players.GetLocalPlayer();
  local_entity = Players.GetPlayerHeroEntityIndex(local_pid);
  if (double_click_tester === "ItemPanelOnActivateSell" + item_index) {
    if (!is_shop_active) {
      $.DispatchEvent('DOTAShowTextTooltip', $("#Shop"), "Not in range of shop");
      $.Schedule(1, function() {
        return $.DispatchEvent('DOTAHideTextTooltip', $("#Shop"));
      });
      return;
    }
    return GameEvents.SendCustomGameEventToServer("SellItem", {
      item_index: item_index
    });
  } else {
    item = Entities.GetItemInSlot(local_entity, item_index);
    item_name = Abilities.GetAbilityName(item);
    item_friendly_name = item_name.substring(5, 6).toUpperCase() + item_name.substring(6);
    item_store_index = Object.keys(items).indexOf(item_friendly_name);
    tier = 2;
    if (item_store_index <= 5) {
      tier = 1;
    }
    if (item_store_index === -1) {
      tier = 3;
    }
    if (tier === 2) {
      item_built_from = null;
      check_item_built_from = function(item_name) {
        if (items[item_name].indexOf(item_friendly_name) >= 0) {
          return item_built_from = item_name;
        }
      };
      ref = Object.keys(items);
      for (i = 0, len = ref.length; i < len; i++) {
        item_name = ref[i];
        check_item_built_from(item_name);
      }
      ShowItems(2, item_built_from);
      ItemPanelOnActivate(2, item_built_from, item_friendly_name);
    }
    if (tier === 3) {
      item_built_from_t2 = null;
      check_item_built_from = function(item_name) {
        if (items[item_name].indexOf(item_friendly_name) >= 0) {
          return item_built_from_t2 = item_name;
        }
      };
      ref1 = Object.keys(items);
      for (j = 0, len1 = ref1.length; j < len1; j++) {
        item_name = ref1[j];
        check_item_built_from(item_name);
      }
      item_built_from_t1 = null;
      check_item_built_from = function(item_name) {
        if (items[item_name].indexOf(item_built_from_t2) >= 0) {
          return item_built_from_t1 = item_name;
        }
      };
      ref2 = Object.keys(items);
      for (k = 0, len2 = ref2.length; k < len2; k++) {
        item_name = ref2[k];
        check_item_built_from(item_name);
      }
      ShowItems(2, item_built_from_t1);
      ShowItems(3, item_built_from_t2);
      ItemPanelOnActivate(3, item_built_from_t1, item_built_from_t2);
    }
    double_click_tester = "ItemPanelOnActivateSell" + item_index;
    return $.Schedule(0.6, function() {
      return double_click_tester = false;
    });
  }
};

ItemPanelOnActivate = function(tier, name, item) {
  var i, item_table, len, ref, t1_item, t2_item, try_assign_t1_item;
  if (tier !== 3 && tier !== -1) {
    ShowItems(tier + 1, item);
  }
  if (double_click_tester === "ItemPanelOnActivate" + item + name + tier) {
    if (!is_shop_active) {
      $.DispatchEvent('DOTAShowTextTooltip', $("#Shop"), "Not in range of shop");
      $.Schedule(1, function() {
        return $.DispatchEvent('DOTAHideTextTooltip', $("#Shop"));
      });
      return;
    }
    t1_item = "";
    t2_item = "";
    if (tier !== -1 && tier === 2) {
      t1_item = name;
    }
    if (tier !== -1 && tier === 3) {
      try_assign_t1_item = function(item_table) {
        if (items[item_table].indexOf(name) >= 0) {
          return t1_item = item_table;
        }
      };
      ref = Object.keys(items);
      for (i = 0, len = ref.length; i < len; i++) {
        item_table = ref[i];
        try_assign_t1_item(item_table);
      }
      t2_item = name;
    }
    GameEvents.SendCustomGameEventToServer("BuyItem", {
      item: item,
      t1_item: t1_item,
      t2_item: t2_item
    });
    return double_click_tester = false;
  } else {
    double_click_tester = "ItemPanelOnActivate" + item + name + tier;
    return $.Schedule(0.6, function() {
      return double_click_tester = false;
    });
  }
};

ShowItems = function(tier, name) {
  var cname, i, item, items_list, j, len, len1, make_item, panel, ref, removeOldSelected, results;
  panel = $("#ShopItemsTier3");
  panel.RemoveAndDeleteChildren();
  panel = $("#ShopItemsTier" + tier);
  panel.RemoveAndDeleteChildren();
  items_list = items[name];
  removeOldSelected = function(cname) {
    var removeFrom;
    removeFrom = $("#Item" + cname + "Panel");
    if (removeFrom !== null) {
      return removeFrom.RemoveClass("shop-item-panel-selected-t" + (tier - 1));
    }
  };
  ref = Object.keys(items);
  for (i = 0, len = ref.length; i < len; i++) {
    cname = ref[i];
    removeOldSelected(cname);
  }
  $("#Item" + name + "Panel").AddClass("shop-item-panel-selected-t" + (tier - 1));
  make_item = function(item) {
    var image_pane, label_pane, root_pane;
    root_pane = $.CreatePanel('Panel', panel, "Item" + item + "Panel");
    root_pane.AddClass("shop-item-panel");
    root_pane.AddClass("flow-right");
    root_pane.AddClass("even-space-vertical");
    root_pane.AddClass("fill");
    if (item !== "") {
      root_pane.SetPanelEvent('onactivate', function() {
        return ItemPanelOnActivate(tier, name, item);
      });
      root_pane.SetPanelEvent('onmouseover', function() {
        return ItemPanelMouseOver(item);
      });
      root_pane.SetPanelEvent('onmouseout', function() {
        return ItemPanelMouseExit(item);
      });
    }
    image_pane = $.CreatePanel('Image', root_pane, "Item" + item + "PanelImage");
    if (item === "") {
      image_pane.AddClass("is-not-visible");
    }
    image_pane.AddClass("shop-item");
    if (tier === 2) {
      image_pane.AddClass("shop-item-t2");
    }
    if (tier === 3) {
      image_pane.AddClass("shop-item-t3");
    }
    image_pane.SetImage("file://{images}/custom_game/items/square_items/" + item.toLowerCase() + ".png");
    if (item !== "") {
      label_pane = $.CreatePanel('Label', root_pane, "Item" + item + "PanelLabel");
      return label_pane.text = item + "\n	Cost: " + costs[item];
    }
  };
  results = [];
  for (j = 0, len1 = items_list.length; j < len1; j++) {
    item = items_list[j];
    results.push(make_item(item));
  }
  UpdateItemCosts();
  return results;
};

OnUpdateStore = function(event) {
  is_shop_active = event.active;
  if (event.active) {
    return $("#ShopTitle").text = "Vitality Forging";
  } else {
    return $("#ShopTitle").text = "Vitality Forging (Out of Range)";
  }
};

ItemPanelInventoryMouseOver = function(item_index, item_name) {
  return $.DispatchEvent('DOTAShowAbilityTooltip', $("#ItemInventory" + item_index + "Panel"), item_name);
};

ItemPanelInventoryMouseExit = function(item_index, item_name) {
  return $.DispatchEvent('DOTAHideAbilityTooltip', $("#ItemInventory" + item_index + "Panel"));
};


function UpdateItemCosts() {
  local_pid = Players.GetLocalPlayer();
  local_hero = Players.GetPlayerHeroEntityIndex(local_pid);
  for(var item in costs) {
    var item_panel = $("#Item" + item + "PanelLabel")
    var cost = costs[item]
    if(item_panel != null) {
      var ingredients = []
      for(var item_source in items) {
        var item_outputs = items[item_source]
        for(var item_output_key in item_outputs) {
          var item_output = item_outputs[item_output_key]
          if(item_output == item) {
            ingredients.push(item_source)
          }
        }
      }
      for(var item_source in items) {
        var item_outputs = items[item_source]
        for(var item_output_key in item_outputs) {
          var item_output = item_outputs[item_output_key]
          for (var i = ingredients.length - 1; i >= 0; i--) {
            var ingredient = ingredients[i]
            if(item_output == ingredient) {
              ingredients.push(item_source)
            }
          }
        }
      }
      for (var i = ingredients.length - 1; i >= 0; i--) {
        var ingredient = ingredients[i]
        if(Entities.HasItemInInventory(local_hero, "item_" + ingredient.toLowerCase())) {
          if(cost > costs[item] - costs[ingredient]) {
            cost = costs[item] - costs[ingredient]
          }
        }
      }
      item_panel.text = item + "\n\tCost: " + cost
    }
  }
}

OnUpdateInventory = function(event) {
  var i, item_index, local_hero, local_pid, panel, results, update_store_item;
  panel = $("#InventoryItem1");
  panel.RemoveAndDeleteChildren();
  panel = $("#InventoryItem2");
  panel.RemoveAndDeleteChildren();
  panel = $("#InventoryItem3");
  panel.RemoveAndDeleteChildren();
  panel = $("#InventoryItem4");
  panel.RemoveAndDeleteChildren();
  panel = $("#InventoryItem5");
  panel.RemoveAndDeleteChildren();
  panel = $("#InventoryItem6");
  panel.RemoveAndDeleteChildren();
  UpdateItemCosts();
  local_pid = Players.GetLocalPlayer();
  local_hero = Players.GetPlayerHeroEntityIndex(local_pid);
  update_store_item = function(item_index) {
    var image_panel, item_friendly_name, item_name;
    item_name = Abilities.GetAbilityName(Entities.GetItemInSlot(local_hero, item_index));
    if (Entities.GetItemInSlot(local_hero, item_index) !== -1) {
      item_friendly_name = item_name.substring(5, 6).toUpperCase() + item_name.substring(6);
      image_panel = $.CreatePanel('Image', $("#InventoryItem" + (item_index + 1)), "ItemInventory" + item_index + "Panel");
      image_panel.SetImage("file://{images}/custom_game/items/square_items/" + item_friendly_name.toLowerCase() + ".png");
      image_panel.SetPanelEvent('onactivate', function() {
        return ItemPanelOnActivateSell(item_index);
      });
      image_panel.SetPanelEvent('onmouseover', function() {
        return ItemPanelInventoryMouseOver(item_index, item_name);
      });
      return image_panel.SetPanelEvent('onmouseout', function() {
        return ItemPanelInventoryMouseExit(item_index, item_name);
      });
    }
  };
  results = [];
  for (item_index = i = 0; i <= 5; item_index = ++i) {
    results.push(update_store_item(item_index));
  }
  return results;
};

GameEvents.Subscribe("UpdateStore", OnUpdateStore);

GameEvents.Subscribe("dota_inventory_changed", OnUpdateInventory);

GameEvents.Subscribe("player_spawn", OnUpdateInventory);

OnUpdateInventory();
