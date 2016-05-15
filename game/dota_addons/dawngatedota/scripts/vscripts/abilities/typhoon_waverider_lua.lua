dofile("deal_damage")

function waveride(event)
	local caster = event.caster
	local target = event.target_points[1]
	local damage_dealt = event.Damage
	local direction = (caster:GetAbsOrigin() - target):Normalized()
	if not IsPhysicsUnit(caster) then Physics:Unit(caster) end
	caster:AddPhysicsVelocity(-direction * 2050)
    local done = false
	Timers:CreateTimer(0.2, function()
			caster:SetPhysicsVelocity (Vector(0, 0, 0))
            done = true
		end
	)
	local hit_targets = { length = 0 }
	Timers:CreateTimer(function()
		local nearby_enemies = FindUnitsInRadius(caster:GetTeam(), caster:GetAbsOrigin(), nil, event.Radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
        for i,nearby in pairs(nearby_enemies) do
            local pass = true
            for j=0, hit_targets.length do
                if hit_targets[j] == nearby then
                    pass = false
                    break
                end
            end
            if pass then
                hit_targets[hit_targets.length] = nearby
                hit_targets.length = hit_targets.length + 1
                deal_damage(caster, nearby, damage_dealt, event.PowerRatio, 2, caster:GetAbilityByIndex(1), false, false, true)
            end
        end
        if done then
            return nil
        end
		return 0.03
	end)
end