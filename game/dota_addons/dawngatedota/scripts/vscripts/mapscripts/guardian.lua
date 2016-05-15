local good_guardian_spawner = Entities:FindByName(nil, "guardian_spawner_good")

local bad_guardian_spawner = Entities:FindByName(nil, "guardian_spawner_bad")

local good_guardian = CreateUnitByName("npc_guardian_good", good_guardian_spawner:GetAbsOrigin() - Vector(0, 0, 2000), false, nil, nil, DOTA_TEAM_GOODGUYS)
good_guardian:SetHullRadius(320)

local bad_guardian = CreateUnitByName("npc_guardian_bad", bad_guardian_spawner:GetAbsOrigin() - Vector(0, 0, 2000), false, nil, nil, DOTA_TEAM_BADGUYS)
bad_guardian:SetHullRadius(320)

local bad_revealer = CreateUnitByName("npc_guardian_revealer", bad_guardian:GetAbsOrigin() + Vector(1, 1, 0), false, nil, nil, DOTA_TEAM_GOODGUYS)
bad_revealer:AddNewModifier(caster, nil, "modifier_invulnerable", {})
local good_revealer = CreateUnitByName("npc_guardian_revealer", good_guardian:GetAbsOrigin() + Vector(-1, -1, 0), false, nil, nil, DOTA_TEAM_BADGUYS)
good_revealer:AddNewModifier(caster, nil, "modifier_invulnerable", {})

Timers:CreateTimer(0.25, function()
	ParticleManager:CreateParticle("particles/guardian/guardianvortex_base.vpcf", PATTACH_ABSORIGIN, good_guardian)
	ParticleManager:CreateParticle("particles/guardian/guardianvortex_base.vpcf", PATTACH_ABSORIGIN, bad_guardian)
end)

local guardian_level = -1
function tick_guardian_level() 
	guardian_level = math.min(20, guardian_level + 1)
	good_guardian.creep_level_armour = guardian_level * 0 + 100
	good_guardian.creep_level_magic_resistance = guardian_level * 0 + 80
	good_guardian.creep_level_power = guardian_level * 5 + 0

	bad_guardian.creep_level_armour = guardian_level * 0 + 100
	bad_guardian.creep_level_magic_resistance = guardian_level * 0 + 80
	bad_guardian.creep_level_power = guardian_level * 5 + 0
	return 60
end
tick_guardian_level()
Timers:CreateTimer(60 * 10, tick_guardian_level)

function tick_guardian(caster)
	if not caster:IsAlive() then
      GameRules:SetSafeToLeave( true )
      if caster == good_guardian then
      	GameRules:SetGameWinner( DOTA_TEAM_BADGUYS )
      else
      	GameRules:SetGameWinner( DOTA_TEAM_GOODGUYS )
      end
	end
	if caster.isCasting then
		caster.guardian_target = nil
		caster:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(caster, caster, "modifier_spiritgate_guardian_disarm", {})
	else
		if caster:GetAttackTarget() ~= nil then
			caster.guardian_target = caster:GetAttackTarget()
		end
		caster:RemoveModifierByName("modifier_spiritgate_guardian_disarm")
	end

	local current_fv = caster:GetForwardVector()
	if caster.guardian_target ~= nil and caster.guardian_target:IsAlive() then
		caster:SetForwardVector((current_fv * 9 -(caster:GetAbsOrigin() - caster.guardian_target:GetAbsOrigin()):Normalized()) / 10)
	else
		if caster == good_guardian then
			caster:SetForwardVector((current_fv * 9 + Vector(1, 1, 0)) / 10)
		else
			caster:SetForwardVector((current_fv * 9 + Vector(-1, -1, 0)) / 10)
		end
	end
	return 1 / 30
end

function cast_missile_barrage(caster, targets)
	local rockets = 10
	while rockets > 0 do
		local target = targets[RandomInt(1, #targets)]

		local targetpos = target:GetAbsOrigin() + Vector(RandomInt(-250, 250), RandomInt(-250, 250), 0)
		targetpos = GetGroundPosition(targetpos, target) + Vector(0, 0, 1)

		local marker_pid = ParticleManager:CreateParticle("particles/guardian/guardian_missile_barrage_marker.vpcf", PATTACH_CUSTOMORIGIN, caster)
		ParticleManager:SetParticleControl(marker_pid, 0, targetpos)

		Timers:CreateTimer(rockets / 10 + 0.75, function()
			local spell = caster:GetAbilityByIndex(0)
			spell:SetLevel(1)
			spell:EndCooldown()
			caster:SetCursorPosition(targetpos)
			spell:OnSpellStart()
			Timers:CreateTimer(math_distance(targetpos, caster:GetAbsOrigin()) / 1000 * 2, function()
				ParticleManager:DestroyParticle(marker_pid, true)
			end)
		end)

		rockets = rockets - 1

		Timers:CreateTimer(0.4, function() 
			StartAnimation(caster, { duration=1, activity=ACT_DOTA_SPAWN, rate=2 }) 
		end)
	end
	caster.guardian_target = targets[1]
	return 3
end

function cast_snare_bubble(caster, targets)
	local ball_count = 16
	for i=1, ball_count do
		Timers:CreateTimer(i / ball_count / 2, function ()
			local angle = i * 360 / ball_count
			local fv = Vector(math.cos(angle * math.pi / 180), math.sin(angle * math.pi / 180), 0)

			local spell = caster:GetAbilityByIndex(1)
			spell:SetLevel(1)
			spell:EndCooldown()
			caster:SetCursorPosition(caster:GetAbsOrigin() + fv)
			spell:OnSpellStart()
		end)
	end
	return 6
end

function cast_doom_laser(caster, targets)
	local target = targets[RandomInt(1, #targets)]
	local spell = caster:GetAbilityByIndex(2)
	spell:SetLevel(1)
	spell:EndCooldown()
	caster:SetCursorPosition(target:GetAbsOrigin())
	spell:OnSpellStart()
	caster.guardian_target = target
	return 8
end

function cast_fire_field(caster, targets)
	local target = targets[RandomInt(1, #targets)]
	local spell = caster:GetAbilityByIndex(3)
	spell:SetLevel(1)
	spell:EndCooldown()
	caster:SetCursorPosition(target:GetAbsOrigin())
	spell:OnSpellStart()
	caster.guardian_target = target
	return 8
end

function tick_guardian_casts(caster)
	if not caster.isCasting then
		local targets = GetEnemiesInRadius(caster, 1500)
		for k, v in ipairs(targets) do
			if not v:IsHero() then
				table.remove(targets, k)
			end
		end
		if #targets > 0 then
			local spells = { cast_missile_barrage, cast_snare_bubble, cast_doom_laser, cast_fire_field }
			local duration = spells[RandomInt(1, #spells)](caster, targets)
			caster.isCasting = true
			caster:SetAttacking(nil)
			Timers:CreateTimer(duration, function()
				caster.isCasting = false
			end)
			return duration + 1
		else
			caster.guardian_target = nil
		end
	end
	return 0.25
end

Timers:CreateTimer(function() return tick_guardian(good_guardian) end)
Timers:CreateTimer(function() return tick_guardian_casts(good_guardian) end)

Timers:CreateTimer(function() return tick_guardian(bad_guardian) end)
Timers:CreateTimer(function() return tick_guardian_casts(bad_guardian) end)