function cast(event)
	local caster = event.caster
	local target = event.target_points[1]
	local range = event.Range
	local ability = event.ability

	local fv = (target - caster:GetAbsOrigin()):Normalized() 

	ability.target = nil

	local pid = ParticleManager:CreateParticle("particles/zalgus_final_chapter/final_chapter_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 100))
	ParticleManager:SetParticleControl(pid, 1, fv * range + caster:GetAbsOrigin() + Vector(0, 0, 100))
end

function fire(event)
	dofile("deal_damage")

	local caster = event.caster
	local ability = event.ability
	local target = event.target_points[1]

	local fv = (target - caster:GetAbsOrigin()):Normalized() 
	local distance_traveled = 0
	local range = event.Range

	local spd = 160

	local pid = ParticleManager:CreateParticle("particles/zalgus_final_chapter/final_chapter_projectile_base.vpcf", PATTACH_CUSTOMORIGIN, nil)

	ParticleManager:SetParticleControl(pid, 0, caster:GetAbsOrigin() + fv * distance_traveled + Vector(0, 0, 100))

	Timers:CreateTimer(function()
		if distance_traveled > range then
			ParticleManager:DestroyParticle(pid, false)
			return
		end
		distance_traveled = distance_traveled + spd

		local enemies = GetEnemiesInRadiusOfPoint(caster:GetAbsOrigin() + fv * distance_traveled, caster:GetTeamNumber(), 80)
		
		for _, enemy in pairs(enemies) do
			if enemy:IsHero() then
				ParticleManager:DestroyParticle(pid, false)
				deal_damage(caster, enemy, event.Damage, event.DamagePowerRatio, 2, event.Ability, false, false, false)
				if not enemy:IsAlive() then
					Timers:CreateTimer(function()
						event.ability:EndCooldown()
						if event.ability.recast_timer ~= nil then
							Timers:RemoveTimer(event.ability.recast_timer)
						end
						event.ability.recast_timer = Timers:CreateTimer(12, function()
							event.ability:StartCooldown(get_ability_cooldown(caster, event.ability))
							event.ability.recast_timer = nil
						end)
					end)
				end
				return
			end
		end

		ParticleManager:SetParticleControl(pid, 0, caster:GetAbsOrigin() + fv * distance_traveled + Vector(0, 0, 100))

		return 1 / 30
	end)
end