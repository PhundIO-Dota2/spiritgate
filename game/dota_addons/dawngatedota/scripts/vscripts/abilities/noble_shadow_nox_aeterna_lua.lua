function cast(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local damage = event.Damage
	local damage_power_ratio = event.DamagePowerRatio

	local fv = (target:GetAbsOrigin() - caster:GetAbsOrigin()):Normalized()
	local distance = (target:GetAbsOrigin() - caster:GetAbsOrigin()):Length2D()
	for i=1,9 do
		local new_pos = caster:GetAbsOrigin() + fv * distance / 9 * (i - 1)
		Timers:CreateTimer((0.3 * i / 9) / 2, function()
			caster:SetAbsOrigin(new_pos)
			FindClearSpaceForUnit(caster, new_pos, false)
			if i == 9 then
				local hit_pid = ParticleManager:CreateParticle("particles/kindra_nox_aeterna/nox_aeterna_hit.vpcf", PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControl(hit_pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 50))
				local enemies = GetEnemiesInRadiusOfPoint(caster:GetAbsOrigin(), caster:GetTeamNumber(), 250)
				dofile("deal_damage")
				for _, enemy in pairs(enemies) do
					if enemy:IsHero() then
						deal_damage(caster, enemy, damage, damage_power_ratio, 2, ability, false, false, true)
						ability:ApplyDataDrivenModifier(caster, caster, "modifier_nox_aeterna_damage_reduction", {})
					end
				end
			end
			if i == 9 and ability.total_casts < 3 then
				ability:EndCooldown()
			end
		end)
	end

	if ability.recast_timer == nil then
		ability.total_casts = 1
		ability.recast_timer = Timers:CreateTimer(6, function()
			ability.total_casts = 0
			ability.recast_timer = nil
		end)
	else
		ability.total_casts = ability.total_casts + 1

		Timers:RemoveTimer(ability.recast_timer)

		if ability.total_casts < 3 then
			ability.recast_timer = Timers:CreateTimer(6, function()
				ability.total_casts = 0
				ability.recast_timer = nil
				ability:StartCooldown(get_ability_cooldown(caster, ability))
			end)
		else
			ability.recast_timer = Timers:CreateTimer((0.3 * 10 / 9) / 2, function()
				ability.total_casts = 0
				ability.recast_timer = nil
				ability:StartCooldown(get_ability_cooldown(caster, ability))
			end)
		end
	end
end