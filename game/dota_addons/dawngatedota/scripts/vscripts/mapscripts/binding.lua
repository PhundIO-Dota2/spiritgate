local BINDING_ATTACK_RANGE = 850

local binding_names = {
	"binding_good_1",
	"binding_good_2",
	"binding_good_3",
	"binding_good_4",
	"binding_good_5",
	"binding_good_6",

	"binding_bad_1",
	"binding_bad_2",
	"binding_bad_3",
	"binding_bad_4",
	"binding_bad_5",
	"binding_bad_6",
}
local binding_teams = {
	DOTA_TEAM_GOODGUYS,
	DOTA_TEAM_GOODGUYS,
	DOTA_TEAM_GOODGUYS,
	DOTA_TEAM_GOODGUYS,
	DOTA_TEAM_GOODGUYS,
	DOTA_TEAM_GOODGUYS,

	DOTA_TEAM_BADGUYS,
	DOTA_TEAM_BADGUYS,
	DOTA_TEAM_BADGUYS,
	DOTA_TEAM_BADGUYS,
	DOTA_TEAM_BADGUYS,
	DOTA_TEAM_BADGUYS,
}
local binding_invulnerability_reliance = { --The binding will become destroyable after the binding with the name is destroyed.
	4,
	3,
	nil,
	nil,
	1,
	2,

	nil,
	nil,
	8,
	7,
	10,
	9,
}

local bindings = {
	
}

function CreateBinding(name, team, reliance) 
	local binding_spawner = Entities:FindByName(nil, name)
	if binding_spawner == nil then
		print("Could not find binding spawner: " .. name)
		return
	end

	local binding = CreateUnitByName("npc_binding", binding_spawner:GetAbsOrigin(), false, nil, nil, team)
	bindings[#bindings + 1] = binding

	if reliance ~= nil then
		binding:AddNewModifier(caster, nil, "modifier_invulnerable", {})
	end

	binding:SetHullRadius(195)
	binding:SetAbsOrigin(GetGroundPosition(binding:GetAbsOrigin(), binding))
	if string.find(name, "bad") then
		binding:SetModel("models/binding/center_bad.vmdl")
		binding:SetOriginalModel("models/binding/center_bad")
		binding_spawner:SetModel("models/binding/base_bad.vmdl")
		local pid = ParticleManager:CreateParticle("particles/binding/binding_pillar_bad.vpcf", PATTACH_CUSTOMORIGIN, binding)
		ParticleManager:SetParticleControl(pid, 0, binding:GetAbsOrigin())
	else
		local pid = ParticleManager:CreateParticle("particles/binding/binding_pillar.vpcf", PATTACH_CUSTOMORIGIN, binding)
		ParticleManager:SetParticleControl(pid, 0, binding:GetAbsOrigin())
	end
	--binding:RemoveModifierByName("modifier_invulnerable")
	--binding:AddNewModifier(binding, nil, "modifier_invulnerable", {})

	binding.fire_cooldown = 0.25
	binding.target = nil

	Timers:CreateTimer(function() return TickBinding(binding, team, reliance) end)
	Timers:CreateTimer(function()
		if binding:IsNull() or not binding:IsAlive() then return end

		AddFOWViewer(DOTA_TEAM_GOODGUYS, binding:GetAbsOrigin(), 10, 1, true)
		AddFOWViewer(DOTA_TEAM_BADGUYS, binding:GetAbsOrigin(), 10, 1, true)
		return 1
	end)
end
function TickBinding(binding, team, reliance)
	if binding:IsNull() or not binding:IsAlive() then 
		if binding.laser_pid then
			ParticleManager:DestroyParticle(binding.laser_pid, true)
		end
		for i in rangepairs(10) do
			if PlayerResource:IsValidPlayer(i - 1) then
				local player = PlayerResource:GetPlayer(i - 1)
				if PlayerResource:GetSelectedHeroEntity(i - 1) ~= nil then
					SendOverheadEventMessage(PlayerResource:GetSelectedHeroEntity(i - 1), OVERHEAD_ALERT_GOLD, PlayerResource:GetSelectedHeroEntity(i - 1), 150, nil)
					
					if PlayerResource:GetTeam(i - 1) ~= team then
						PlayerResource:ModifyGold(i - 1, 150, true, 0)
					end
				end
			end
		end
		return
	end

	local universal_ability = binding:FindAbilityByName("ability_universal_ability")
	universal_ability:ApplyDataDrivenModifier(binding, binding, "modifier_hidden_level_armour", {})
	universal_ability:ApplyDataDrivenModifier(binding, binding, "modifier_hidden_level_magic_resistance", {})

	local spell = binding:GetAbilityByIndex(0)
	binding:SetModifierStackCount("modifier_hidden_level_armour", universal_ability, 50)
	binding:SetModifierStackCount("modifier_hidden_level_magic_resistance", universal_ability, 150)

	if not binding.target then
		local targets = GetEnemiesInRadius(binding, BINDING_ATTACK_RANGE)
		if #targets > 0 then
			local found_minion = false
			for k, target in ipairs(targets) do
				if not target:IsHero() then 
					found_minion = true
					binding.target = target
					binding:RemoveModifierByName("modifier_targetting_shaper")
					binding:RemoveModifierByName("modifier_targetting_shaper_stack")
				end
			end
			if not found_minion then
				for k, target in ipairs(targets) do 
					binding.target = target
					spell:ApplyDataDrivenModifier(binding, binding, "modifier_targetting_shaper", {})
					spell:ApplyDataDrivenModifier(binding, binding, "modifier_targetting_shaper_stack", {})
				end
			end
		end
	elseif binding.target and binding.fire_cooldown > 0 then
		binding.fire_cooldown = binding.fire_cooldown - 1 / 30
	elseif binding.target then
		if binding.target:IsNull() or not binding.target:IsAlive() or math_distance(binding, binding.target) > BINDING_ATTACK_RANGE then
			binding.target = nil --Try to reset target
			binding.fire_cooldown = 0.25
			return 1 / 30
		end
		if binding.target:IsHero() then
			binding:SetModifierStackCount("modifier_targetting_shaper_stack", spell, binding:GetModifierStackCount("modifier_targetting_shaper_stack", spell) + 25)
		else
			binding:RemoveModifierByName("modifier_targetting_shaper_stack")
		end
		spell:SetLevel(1)
		spell:EndCooldown()
		binding:SetCursorCastTarget(binding.target)
		spell:OnSpellStart()
		binding.fire_cooldown = 1.5 --ATTACKSPEED
	end
	if binding.target ~= nil and not binding.target:IsNull() then
		local target_vector = -(binding:GetAbsOrigin() - binding.target:GetAbsOrigin()):Normalized()
		target_vector = Vector(target_vector.x, target_vector.y, 0)
		binding:SetForwardVector((binding:GetForwardVector() * 9 + target_vector) / 10)
	end
	if not binding.target then
		binding:RemoveModifierByName("modifier_targetting_shaper_stack")
		binding:RemoveModifierByName("modifier_targetting_shaper")
	end
	if binding.target then
		if not binding.laser_pid then
			binding.laser_pid = ParticleManager:CreateParticle("particles/binding/laser.vpcf", PATTACH_CUSTOMORIGIN, binding)
		end

		ParticleManager:SetParticleControl(binding.laser_pid, 0, binding.target:GetAbsOrigin() + Vector(0, 0, 50))
		ParticleManager:SetParticleControl(binding.laser_pid, 1, binding:GetAbsOrigin() + Vector(0, 0, 250))
	end
	if not binding.target or math_distance(binding.target, binding) > BINDING_ATTACK_RANGE then
		if binding.laser_pid then
			ParticleManager:DestroyParticle(binding.laser_pid, true)
			binding.laser_pid = nil
		end
	end

	if reliance ~= nil and bindings[reliance]:IsNull() then
	  binding:RemoveModifierByName("modifier_invulnerable")
    end
	return 1 / 30
end

for i=1, #binding_names do
	CreateBinding(binding_names[i], binding_teams[i], binding_invulnerability_reliance[i])
end