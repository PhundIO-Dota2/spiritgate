--[[

Event Parameters:
	Target: Should always be "POINT"
	Caster: Usually "CASTER"
	Speed: Projectile speed in Hammer Units / second
]]

function cast(event)
	dofile("deal_damage")

	local caster = event.caster
	local target = event.target_points[1]
	local hit_effect_table = event.HitEffect
	local unit = CreateUnitByName("npc_typhoon_riptide", caster:GetAbsOrigin(), false, caster, caster, caster:GetTeamNumber())
	
	unit:AddNewModifier(caster, nil, "modifier_invulnerable", {})
	local pid = ParticleManager:CreateParticle(event.EffectName, PATTACH_CUSTOMORIGIN, unit)
	unit:SetHullRadius(0)
	Timers:CreateTimer(10, function()
		if unit:IsNull() then return end
		unit:Destroy()
	end)

	local fv = -(caster:GetAbsOrigin() - target):Normalized()
	local velocity = fv * event.Speed / 30
	Timers:CreateTimer(function()
		ParticleManager:SetParticleControl(pid, 0, GetGroundPosition(unit:GetAbsOrigin(), unit) + Vector(0, 0, 100))
		unit:SetAbsOrigin(unit:GetAbsOrigin() + velocity)
		if math_distance(unit:GetAbsOrigin(), target) < event.Speed / 30 / 2 then
			if hit_effect_table ~= nil then
				for k, v in pairs(hit_effect_table) do
					if k == "ApplyModifier" then
						apply_modifier(v, event)
					elseif k == "Damage" then
						damage(v, event)
					elseif k == "AddStacks" then
						add_stacks(v, event)
					elseif k == "FireSound" then
						EmitSoundOn(v.EffectName, unit)
					elseif k == "Disable" then
						for k, target in ipairs(getTargets(v, event)) do
							disable({
								caster = caster,
								target = target,
								Duration = v.Duration,
								DurationPowerRatio = v.DurationPowerRatio,
								DisableModifier = v.DisableModifier,
								ability = event.ability	
							})
						end
					end
				end
			end
			ParticleManager:DestroyParticle(pid, false)
			pid = ParticleManager:CreateParticle(event.EffectEndcapName, PATTACH_CUSTOMORIGIN, unit)
			ParticleManager:SetParticleControl(pid, 0, GetGroundPosition(unit:GetAbsOrigin(), unit) + Vector(0, 0, 150))
			return nil
		end
		return 1 / 30
	end)
end

function getTargets(v, event)
	if v.Target == "RADIUS" then
		return GetEnemiesInRadiusOfPoint(event.target_points[1], event.caster:GetTeamNumber(), v.Radius)
	end
end

function add_stacks(v, event)
	dofile("modifier_helper")
	local new_event = {}
	if v.Caster == "CASTER" then
		new_event.caster = event.caster
	end
	if v.Caster == "TARGET" then
		new_event.caster = event.target
	end

	local targets = getTargets(v, event)

	local source_ability = event.ability
	if source_ability == "UNIVERSAL" then
		source_ability = caster:FindAbilityByName("ability_universal_ability")
	end
	new_event.ability = source_ability

	new_event.Stacks = v.Stacks
	new_event.MaxStacks = v.MaxStacks
	new_event.ModifierName = v.ModifierName
	new_event.PowerRatio = v.PowerRatio
	new_event.Duration = v.Duration

	for k, v in ipairs(targets) do 
		new_event.target = v
		AddStacks(new_event)
	end
end

function apply_modifier(v, event) 
	local caster = event.caster
	--local target_point = event.target_points[1]

	local targets = getTargets(v, event)
	local modifier_name = v.ModifierName

	local source_ability = event.ability

	if source_ability == "UNIVERSAL" then
		source_ability = caster:FindAbilityByName("ability_universal_ability")
	end

	for k, v in ipairs(targets) do
		source_ability:ApplyDataDrivenModifier(caster, v, modifier_name, {})
	end
end

function damage(v, event) 
	dofile("deal_damage")
	local amount = v.Amount
	local power_ratio = v.PowerRatio
	local targets = getTargets(v, event)
	for k, v in ipairs(targets) do
		deal_damage(event.caster, v, amount, power_ratio, event.ability:GetAbilityDamageType(), event.ability, false, false, v.Target == "RADIUS")
	end
end