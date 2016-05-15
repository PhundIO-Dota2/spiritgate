function cast(event)
	local caster = event.caster
	local pid = ParticleManager:CreateParticle("particles/dibs_reverie/reverie_base.vpcf", PATTACH_CUSTOMORIGIN, caster)
	local start_pid = ParticleManager:CreateParticle("particles/dibs_reverie/reverie_begin_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(start_pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 75))
	local time_left = 300

	caster:SwapAbilities("ability_tangled_dreamer_reverie", "ability_tangled_dreamer_reverie_fly", false, true)
	caster:FindAbilityByName("ability_tangled_dreamer_reverie_fly"):SetLevel(event.ability:GetLevel())

	Timers:CreateTimer(function()
		time_left = time_left - 1
		ParticleManager:SetParticleControl(pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 50) - caster:GetForwardVector() * 35)
		ParticleManager:SetParticleControlForward(pid, 0, caster:GetForwardVector())
		if time_left <= 0 then
			ParticleManager:DestroyParticle(pid, true)
			return
		end
		return 1 / 30
	end)
	event.ability.reset_timer = Timers:CreateTimer(function()
		if time_left <= 0 then
			caster:SwapAbilities("ability_tangled_dreamer_reverie", "ability_tangled_dreamer_reverie_fly", true, false)
			ability:SetLevel(caster:FindAbilityByName("ability_tangled_dreamer_reverie_fly"):GetLevel())
			return
		end
		return 1 / 4
	end)
	Timers:CreateTimer(function()
		if time_left <= 0 then
			return
		end
		local targets = GetFriendliesInRadiusOfPoint(caster:GetAbsOrigin(), caster:GetTeamNumber(), event.Radius)
		for k, target in ipairs(targets) do
			event.ability:ApplyDataDrivenModifier(caster, target, "modifier_reverie_power", {})
			target:SetModifierStackCount("modifier_reverie_power", caster, event.AddedPower + event.PowerRatio * find_stat(caster, "power"))
		end
		return 1 / 4
	end)
end

function recast(event)
	local caster = event.caster
	local target = event.target_points[1]

	local pid = ParticleManager:CreateParticle("particles/dibs_reverie/reverie_flylocation_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, target)
	
	caster:SwapAbilities("ability_tangled_dreamer_reverie", "ability_tangled_dreamer_reverie_fly", true, false)
	caster:FindAbilityByName("ability_tangled_dreamer_reverie"):SetLevel(event.ability:GetLevel())
	Timers:RemoveTimer(caster:FindAbilityByName("ability_tangled_dreamer_reverie").reset_timer)
	caster:SetMoveCapability(DOTA_UNIT_CAP_MOVE_FLY)
	Timers:CreateTimer(function()
		if not caster:IsAlive() then return end
		caster:SetAbsOrigin(caster:GetAbsOrigin() + -50 * (caster:GetAbsOrigin() - target):Normalized())
		if math_distance(caster:GetAbsOrigin(), target) < 60 then
			caster:SetAbsOrigin(target)
			caster:SetMoveCapability(DOTA_UNIT_CAP_MOVE_GROUND)
			FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), false)
			ParticleManager:DestroyParticle(pid, true)
			return
		end
		return 1 / 30
	end)
end