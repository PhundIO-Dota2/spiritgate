function cast(event)
	dofile("deal_damage")

	local caster = event.caster
	local target = event.target_points[1]
	local ability = event.ability

	local pid = ParticleManager:CreateParticle("particles/kom_endless_delights/endless_delights_projectile_base.vpcf", PATTACH_CUSTOMORIGIN, nil)

	local pos = caster:GetAbsOrigin()
	local fv = (target - caster:GetAbsOrigin()):Normalized()
	local spd = 27
	local distance = (target - caster:GetAbsOrigin()):Length2D()
	local scale = distance / event.CastRange
	local distance_travelled = 0

	local hit_enemies = {} 

	local potential_witnesses = GetEnemiesInRadiusOfPoint(pos, caster:GetTeamNumber(), 1200)
	for k, potential_witness in pairs(potential_witnesses) do
		if caster:HasModifier("modifier_mad_king_flourish") and potential_witness:IsHero() and caster:CanEntityBeSeenByMyTeam(potential_witness) then
			local flourish = caster:FindAbilityByName("ability_mad_king_flourish")
			if flourish.is_awaiting_cast then
				Timers:RemoveTimer(flourish.is_awaiting_cast_timer)
				flourish.is_awaiting_cast = false
				flourish.next_cast_is_recast = true
				Timers:CreateTimer(3, function()
					flourish:StartCooldown(get_ability_cooldown(caster, flourish))
					flourish.next_cast_is_recast = false
				end)
				flourish:EndCooldown()
			end
		end
	end

	local should_use_flourish = caster:HasModifier("modifier_mad_king_flourish")

	if should_use_flourish then
		caster:RemoveModifierByName("modifier_mad_king_flourish")
	end

	ParticleManager:SetParticleControl(pid, 0, pos)

	Timers:CreateTimer(function()
		distance_travelled = distance_travelled + spd
		pos = pos + fv * spd
		local height_offset = 225 * scale + (distance_travelled * scale - math.pow((distance_travelled - event.CastRange / 2) * scale, 2)) / 1000 * 3
		ParticleManager:SetParticleControl(pid, 0, pos + Vector(0, 0, height_offset))
		if distance_travelled > distance then
			ParticleManager:DestroyParticle(pid, true)
			local egg_offsets = {
				Vector(0, 0.5, 0),
				Vector(0.35, 0.25, 0),
				Vector(-0.35, 0.25, 0),
				Vector(0.2, -0.3, 0),
				Vector(-0.2, -0.3, 0),
				Vector(0, 0, 0)
			}
			for i=1, 6 do
				local egg_pos = pos + egg_offsets[i] * 230
				local egg_pid = ParticleManager:CreateParticle("particles/kom_endless_delights/endless_delight_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControl(egg_pid, 0, egg_pos)
				local destroy_egg_timer = -1
				local destroy_egg = function()
					ParticleManager:DestroyParticle(egg_pid, false)
					local splat_pid = ParticleManager:CreateParticle("particles/kom_endless_delights/endless_delight_splat_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
					ParticleManager:SetParticleControl(splat_pid, 0, egg_pos)
					destroy_egg_timer = nil
				end
				destroy_egg_timer = Timers:CreateTimer(3, destroy_egg)

				local should_flourish = false
				if should_use_flourish then
					should_flourish = true
					local flourish_pid = ParticleManager:CreateParticle("particles/kom_endless_delights/endless_delights_empowered_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
					ParticleManager:SetParticleControl(flourish_pid, 0, egg_pos)
					Timers:CreateTimer(1.5, function()
						should_flourish = false
						ParticleManager:DestroyParticle(flourish_pid, true)
					end)

				end

				Timers:CreateTimer(function()
					local target_enemy = GetEnemiesInRadiusOfPoint(egg_pos, caster:GetTeamNumber(), 110)[1]
					if target_enemy ~= nil then
						Timers:RemoveTimer(destroy_egg_timer)
						destroy_egg()
						if should_flourish then
							caster:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(caster, target_enemy, "modifier_fear", { Duration = event.FlourishFearDuration })
						end
						local damage_mult = 1
						if tableContains(hit_enemies, target_enemy) then
							damage_mult = 0.25
						else
							hit_enemies[#hit_enemies + 1] = target_enemy
						end
						deal_damage(caster, target_enemy, event.Damage * damage_mult, event.DamagePowerRatio * damage_mult, 2, event.ability, false, false, true)
						return
					end
					if destroy_egg_timer == nil then
						return
					end
					return 1 / 15
				end)
			end
			return
		end
		return 1 / 30
	end)
end