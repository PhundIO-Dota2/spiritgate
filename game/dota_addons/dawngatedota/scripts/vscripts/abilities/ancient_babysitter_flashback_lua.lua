function on_spell_start(event)
	dofile("deal_damage")
	local caster = event.caster
	local point = event.target_points[1]
	local volleys = event.Volleys
	local speed = 100
	local ability = event.ability

	local origin = caster:GetAbsOrigin()
	local original_origin = caster:GetAbsOrigin()

	local fv = -(origin - point):Normalized()

	local flashback_unit = CreateUnitByName("npc_typhoon_riptide", caster:GetAbsOrigin(), false, caster, caster, caster:GetTeamNumber())
	flashback_unit:SetForwardVector(fv)
	flashback_unit:AddNewModifier(caster, nil, "modifier_invulnerable", {})
	local rootPartID = ParticleManager:CreateParticle("particles/faris_access_memory/memory.vpcf", PATTACH_ABSORIGIN_FOLLOW, flashback_unit)
	ParticleManager:SetParticleControlOrientation(rootPartID, 0, fv, flashback_unit:GetRightVector(), flashback_unit:GetUpVector())

	local start_origin = caster:GetAbsOrigin()

	EmitSoundOn("Hero_AncientBabysitter.AbilityFlashbackCast", caster)

	Timers:CreateTimer(function()
		local origin = caster:GetAbsOrigin()
		local fv = -(origin - point):Normalized()
		caster:SetAbsOrigin(origin + fv * speed)

		local old_origin = caster:GetAbsOrigin()
		local new_origin = caster:GetAbsOrigin()

		local distance_sq = math.abs(math.pow(new_origin.x - start_origin.x, 2) + math.pow(new_origin.y - start_origin.y, 2))

		ability:StartCooldown(1)

		if distance_sq >= event.Range * event.Range or old_origin ~= new_origin or math.abs(math.pow(origin.x - point.x, 2) + math.pow(origin.y - point.y, 2)) < speed * speed then
			FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), false)
			local enemies = GetEnemiesInRadius(caster, event.Radius, false)
			for k, enemy in ipairs(enemies) do
				deal_damage(caster, enemy, event.Damage, event.DamagePowerRatio, 2, ability, false, false, true)
				disable({
					caster = caster,
					target = enemy,
					Duration = event.Duration,
					DurationPowerRatio = 0,
					DisableModifier = "modifier_flashback",
					ability = ability
				})
				--ability:ApplyDataDrivenModifier(caster, enemy, "modifier_flashback", { })
			end
			Timers:CreateTimer(0.08, function()
				caster:SwapAbilities("ability_ancient_babysitter_flashback", "ability_ancient_babysitter_flashback_return", false, true)
				local return_ability = caster:FindAbilityByName("ability_ancient_babysitter_flashback_return")
				return_ability.flashback_unit = flashback_unit
				return_ability.flashback_particle = rootPartID
				return_ability.return_pos = original_origin
				return_ability.did_return = false
				return_ability:SetLevel(ability:GetLevel())
				return_ability.timer_name = Timers:CreateTimer(3, function()
					if not return_ability.did_return and not return_ability.flashback_unit:IsNull() and ability:GetAbilityIndex() ~= 2 then
						caster:SwapAbilities("ability_ancient_babysitter_flashback", "ability_ancient_babysitter_flashback_return", true, false)
						return_ability.flashback_unit:Destroy()
					end
				end)
			end)
			return nil
		end
		return 1 / 30
	end)
end

function return_to_position(event)
	local ability = event.ability
	local caster = event.caster
	local point = event.ability.return_pos

	ability.did_return = true
	Timers:RemoveTimer(ability.timer_name)

	EmitSoundOn("Hero_AncientBabysitter.AbilityFlashbackReturn", caster)

	caster:SetAbsOrigin(point)
	FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), false)
	caster:SwapAbilities("ability_ancient_babysitter_flashback", "ability_ancient_babysitter_flashback_return", true, false)
	ability.flashback_unit:Destroy()
	ParticleManager:DestroyParticle(ability.flashback_particle, true)
end