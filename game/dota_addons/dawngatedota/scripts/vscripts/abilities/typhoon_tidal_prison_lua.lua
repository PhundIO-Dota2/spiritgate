function cast(event)
	local caster = event.caster
	local target = event.target_points[1]
	local ability = event.ability

	local fv = (target - caster:GetAbsOrigin()):Normalized()
	local spd = 25
	local travelled = 0
	local pos = caster:GetAbsOrigin()
	local pid = ParticleManager:CreateParticle("particles/amarynth_tidal_prison/tidal_prison_base_ability.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, pos)
	Timers:CreateTimer(function()
        pos = pos + fv * spd
        travelled = travelled + spd
        ParticleManager:SetParticleControl(pid, 0, pos + Vector(0, 0, 100))
        ParticleManager:SetParticleControl(pid, 1, pos + Vector(0, 0, 100))
        ParticleManager:SetParticleControl(pid, 3, pos + Vector(0, 0, 100))
        local enemies = GetEnemiesInRadiusOfPoint(pos, caster:GetTeamNumber(), 70)
        dofile("deal_damage")
        for _, enemy in pairs(enemies) do
        	local timer = 0
        	Timers:CreateTimer(0.1, function()
        		timer = timer + 0.1
        		if timer >= 2.5 or not enemy:IsAlive() then
        			local hit_enemies = GetEnemiesInRadiusOfPoint(target, caster:GetTeamNumber(), 200)
        			for _, hit in pairs(hit_enemies) do
        				deal_damage(caster, hit, event.Damage, event.DamagePowerRatio, 2, ability, false, false, true)
    				end
    				if enemy:IsAlive() then
    					enemy:RemoveModifierByName("modifier_tidal_prison")
    				end
    				return
        		end
        		return 0.1
    		end)
    		ability:ApplyDataDrivenModifier(caster, enemy, "modifier_tidal_prison", {})
    		disable( {
    			caster=caster,
    			target=enemy,
    			Duration=event.Duration,
    			DisableModifier="modifier_tidal_prison_slowed",
    			ability=ability,
    			} )
        	ParticleManager:DestroyParticle(pid, false)
        	return
        end
        if travelled > event.Radius then
        	ParticleManager:DestroyParticle(pid, false)
        	return
        end
        return 1 / 30
	end)
end