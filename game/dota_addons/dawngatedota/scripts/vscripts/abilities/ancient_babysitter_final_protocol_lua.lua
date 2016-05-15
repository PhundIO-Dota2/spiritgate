function on_spell_start(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target
	local radius = event.Radius
	local targets = {}
	local targets_part_id = {}
	local done = false
	--"particles/faris_final_protocol/final_protocol_sky_rocket.vpcf"
	local fv = -(caster:GetAbsOrigin() - target:GetAbsOrigin()):Normalized()
	local root_unit = CreateUnitByName("npc_typhoon_riptide", caster:GetAbsOrigin(), false, caster, caster, caster:GetTeamNumber())
	root_unit:SetForwardVector(fv)
	root_unit:AddNewModifier(caster, nil, "modifier_invulnerable", {})
	local rootPartID = ParticleManager:CreateParticle("particles/faris_final_protocol/final_protocol_image.vpcf", PATTACH_ABSORIGIN, root_unit)
	ParticleManager:SetParticleControlOrientation(rootPartID, 0, fv, root_unit:GetRightVector(), root_unit:GetUpVector())
	
	local missile_launch_part_id = ParticleManager:CreateParticle("particles/faris_final_protocol/final_protocol_sky_rocket.vpcf", PATTACH_ABSORIGIN, root_unit)

	Timers:CreateTimer(function() 
		if done then 
			local enemies = GetEnemiesInRadiusOfClosest(caster, target, radius)
			local missiles_left = event.Shots
			local consecutive = false
			while missiles_left > 0 do
				for k, enemy in ipairs(enemies) do
					if enemy:IsHero() and missiles_left > 0 then
						local consecutive_stored = consecutive
						Timers:CreateTimer((event.Shots - missiles_left) / 5, function()
							drop_missile_on(event, enemy, targets_part_id[enemy], consecutive_stored)
						end)
						missiles_left = missiles_left - 1
					end
				end
				consecutive = true
			end
			return 
		end
		local enemies = GetEnemiesInRadiusOfClosest(caster, target, radius)
		for k, enemy in ipairs(targets) do
			if enemy:IsHero() and not tableContains(enemies, enemy) then
				ParticleManager:DestroyParticle(targets_part_id[enemy], true)
				targets_part_id[enemy] = nil
				table.remove(targets, k)
			end
		end
		for k, enemy in ipairs(enemies) do
			if enemy:IsHero() and not tableContains(targets, enemy) and enemy:IsHero() then
				targets[k] = enemy
				targets_part_id[enemy] = ParticleManager:CreateParticle("particles/faris_final_protocol/final_protocol_target_base.vpcf", PATTACH_OVERHEAD_FOLLOW, enemy)
			end
		end
		return 1 / 30
	end)
	Timers:CreateTimer(event.Delay, function()
		done = true
		root_unit:Destroy()
	end)
end
function drop_missile_on(event, target, pid, consecutive)
	local part_id = ParticleManager:CreateParticle("particles/faris_final_protocol/final_protocol_mini_rocket_base.vpcf", PATTACH_CUSTOMORIGIN, target)
	ParticleManager:SetParticleControl(part_id, 0, target:GetAbsOrigin() + Vector(0, 0, 1000))
	ParticleManager:SetParticleControl(part_id, 1, target:GetAbsOrigin())

	Timers:CreateTimer(function()
		if part_id == -1 then return end
		ParticleManager:SetParticleControl(part_id, 1, target:GetAbsOrigin())
		return 0.01
	end)
	local multi = 1
	if consecutive then multi = multi * event.ConsecutiveReduction end
	Timers:CreateTimer(0.8, function()
		part_id = -1
		ParticleManager:DestroyParticle(pid, true)
		deal_damage(event.caster, target, event.Damage * multi, event.DamagePowerRatio * multi, 2, event.ability, false, false, true)
	end)
end