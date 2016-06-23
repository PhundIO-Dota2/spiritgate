-- This is the entry-point to your game mode and should be used primarily to precache models/particles/sounds/etc

require('internal/util')
require('spiritgate_math_util')
require('libraries/projectiles')
require('libraries/physics')
require('libraries/animations')
require('gamemode')
require('stat_finder')
require("libraries/notifications")
require("CosmeticLib")
require('libraries/attachmanager')

function Precache( context )
--[[
  This function is used to precache resources/units/items/abilities that will be needed
  for sure in your game and that will not be precached by hero selection.  When a hero
  is selected from the hero selection screen, the game will precache that hero's assets,
  any equipped cosmetics, and perform the data-driven precaching defined in that hero's
  precache{} block, as well as the precache{} block for any equipped abilities.
  See GameMode:PostLoadPrecache() in gamemode.lua for more information
  ]]

  --DebugPrint("[BAREBONES] Performing pre-load precache")

  -- Particles can be precached individually or by folder
  -- It it likely that precaching a single particle system will precache all of its children, but this may not be guaranteed
  --PrecacheResource("particle", "particles/econ/generic/generic_aoe_explosion_sphere_1/generic_aoe_explosion_sphere_1.vpcf", context)
  --PrecacheResource("particle_folder", "particles/test_particle", context)

  -- Models can also be precached by folder or individually
  -- PrecacheModel should generally used over PrecacheResource for individual models
  --PrecacheResource("model_folder", "particles/heroes/antimage", context)
  --PrecacheResource("model", "particles/heroes/viper/viper.vmdl", context)
  --PrecacheModel("models/heroes/viper/viper.vmdl", context)

  -- Sounds can precached here like anything else
  --PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_gyrocopter.vsndevts", context)

  -- Entire items can be precached by name
  -- Abilities can also be precached in this way despite the name
  --PrecacheItemByNameSync("example_ability", context)
  --PrecacheItemByNameSync("item_example_item", context)

  -- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
  -- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
  --PrecacheUnitByNameSync("npc_dota_hero_ancient_apparition", context)
  --PrecacheUnitByNameSync("npc_dota_hero_enigma", context)

  PrecacheResource("soundfile", "soundevents/shaper_sounds.vsndevts", context)

  PrecacheResource("particle", "particles/ui_mouseactions/clicked_basemove.vpcf", context)
  PrecacheResource("particle", "particles/radius_indicator/radius_indicator.vpcf", context)

  PrecacheResource( "model", "models/development/invisiblebox.vmdl", context )

  PrecacheResource("particle", "particles/healed/healed_base.vpcf", context)
  
  PrecacheUnitByNameSync("npc_typhoon_riptide", context)

  PrecacheUnitByNameSync("npc_jungle_small_shroom", context)
  PrecacheUnitByNameSync("npc_jungle_big_shroom", context)
  PrecacheUnitByNameSync("npc_jungle_cute_shroom", context)
  PrecacheUnitByNameSync("npc_jungle_small_fish", context)
  PrecacheUnitByNameSync("npc_jungle_big_fish", context)
  PrecacheUnitByNameSync("npc_jungle_scary_fish", context)
  PrecacheUnitByNameSync("npc_jungle_small_ugger", context)
  PrecacheUnitByNameSync("npc_jungle_big_ugger", context)
  PrecacheUnitByNameSync("npc_jungle_ugly_ugger", context)
  PrecacheUnitByNameSync("npc_jungle_big_boar", context)
  PrecacheUnitByNameSync("npc_jungle_small_boar", context)

  PrecacheResource("particle", "particles/jungle_buffs/haste_buff.vpcf", context)
  PrecacheResource("particle", "particles/jungle_buffs/armor_buff.vpcf", context)
  PrecacheResource("particle", "particles/jungle_buffs/power_buff.vpcf", context)

  PrecacheUnitByNameSync("npc_creep_melee", context)
  PrecacheUnitByNameSync("npc_creep_ranged", context)
  PrecacheUnitByNameSync("npc_spiritgate_ward", context)
  PrecacheResource("particle", "particles/spward/ward_base.vpcf", context)

  PrecacheUnitByNameSync("npc_guardian_good", context)
  PrecacheUnitByNameSync("npc_guardian_bad", context)
  PrecacheUnitByNameSync("npc_guardian_revealer", context)
  PrecacheResource("particle", "particles/guardian/guardianvortex_base.vpcf", context)

  PrecacheUnitByNameSync("npc_binding", context)
  PrecacheModel("models/binding/center_bad.vmdl", context)
  PrecacheModel("models/binding/base_bad.vmdl", context)
  PrecacheModel("models/binding/pillars_bad.vmdl", context)
  PrecacheResource("particle", "particles/spiritwell/spiritwell_lock_base.vpcf", context)
  PrecacheResource("particle", "particles/spiritwell/spiritwell_lockpoof.vpcf", context)
  PrecacheResource("particle", "particles/spiritwell/spiritwell_base.vpcf", context)
  PrecacheResource("particle", "particles/bidning/binding_pillar.vpcf", context)
  PrecacheResource("particle", "particles/bidning/binding_pillar_bad.vpcf", context)

  PrecacheResource("particle", "particles/shock/shock.vpcf", context)
  PrecacheResource("particle", "particles/potency/zuus_lightning_bolt.vpcf", context)
  PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf", context)
  PrecacheResource("particle", "particles/slow_particles/slow_effect.vpcf", context)
  PrecacheResource("particle", "particles/purity/purityblob_base.vpcf", context)

  PrecacheUnitByNameSync("npc_well_worker", context)
  PrecacheResource("particle", "particles/wellworker/wellworker_effect1.vpcf", context)

  PrecacheUnitByNameSync("npc_high_huntress_talah", context)
  
  PrecacheModel("models/heroes/faris/farism.vmdl", context)
  PrecacheResource("particle", "particles/faris_glows/faris_blade_base.vpcf", context)

  PrecacheUnitByNameSync("npc_winters_bride_iceberg", context)

  PrecacheResource("particle", "particles/zeri_weapon/weapon_particle_base.vpcf", context)

  PrecacheResource("particle", "particles/targeting/line.vpcf", context)
  PrecacheResource("particle", "particles/targeting/range.vpcf", context)
  PrecacheResource("particle", "particles/targeting/global_target.vpcf", context)
  PrecacheResource("particle", "particles/targeting/cone.vpcf", context)

  PrecacheResource("particle", "particles/kom_endless_delights/endless_delights_projectile_base.vpcf", context)
  PrecacheResource("particle", "particles/fenmore_heart_eater/heart_eater_base.vpcf", context)

  PrecacheModel("models/items/faceless_void/battlefury/battlefury.vmdl", context)
  PrecacheModel("models/heroes/sand_king/sand_king_spike.vmdl", context)

  AttachManager:AddModel( 'models/items/faceless_void/battlefury/battlefury.vmdl', Vector( 0, -110, 70 ), Vector( 0, 0, 1 ) )
  AttachManager:AddModel( 'models/heroes/sand_king/sand_king_spike.vmdl', Vector( 0, 0, 0), Vector( 0, 0, -1 ) )
end

-- Create the game mode when we activate
function Activate()
  GameRules.GameMode = GameMode()
  GameRules.GameMode:InitGameMode()
  GameRules:GetGameModeEntity():SetCustomGameForceHero( "npc_dota_hero_bane" )
end