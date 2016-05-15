function transfuse(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target
	local nearby_allies = FindUnitsInRadius(caster:GetTeam(), caster:GetAbsOrigin(), nil, 800, 
		DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
	for i, nearby_ally in ipairs(nearby_allies) do
		if nearby_ally ~= caster then
			local particle = ParticleManager:CreateParticle("particles/purity/purityblob_base.vpcf", PATTACH_CUSTOMORIGIN, nearby_ally)

			local pos = caster:GetAbsOrigin()

			Timers:CreateTimer(function()
					ParticleManager:SetParticleControl(particle, 0, pos + Vector(0, 0, 100))
					if math_distance(pos, nearby_ally:GetAbsOrigin()) < 80 then
						ParticleManager:DestroyParticle(particle, false)
						deal_damage_heal(caster, nearby_ally, 30, 0, 0)
					else
						pos = pos + (nearby_ally:GetAbsOrigin() -pos):Normalized() * 18
						return 1 / 30
					end
				end
			)
		end
	end
end