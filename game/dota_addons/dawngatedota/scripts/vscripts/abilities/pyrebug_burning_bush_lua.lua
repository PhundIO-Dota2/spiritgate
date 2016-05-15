function cast(event)
	local caster = event.caster
	local ability = event.ability

	local furthest_bush_origin_distance = 100000
	local bush_points = {}
	local bush_origin = nil


	for bush_origin_point, bush_origin_data in pairs(existing_revealer_groups) do
		local length = (bush_origin_point - caster:GetAbsOrigin()):Length2D()
		if length <= furthest_bush_origin_distance and length <= 380 then

			furthest_bush_origin_distance = length
			bush_origin = bush_origin_point
		end
	end

	if bush_origin == nil then
		return
	end

	bush_points = init_revealer_group(bush_origin)

	local pride_shaper = caster:FindAbilityByName("ability_pride_shaper")
	local affected = { }

	local done = false

	for _, bush_point in pairs(bush_points) do
		for i=0, 2 do
			local pid = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/golem_ambient_fire_mouth_b.vpcf", PATTACH_CUSTOMORIGIN, nil)
			ParticleManager:SetParticleControl(pid, 12, bush_point + RandomVector(40))

			Timers:CreateTimer(RandomFloat(9.25, 10), function()
				ParticleManager:DestroyParticle(pid, false)
			end)
		end
	end
	Timers:CreateTimer(10, function()
		done = true
	end)
	Timers:CreateTimer(0.25, function()
		if done then return end
		for _, affected_unit in pairs(affected) do
			pride_shaper:ApplyDataDrivenModifier(caster, affected_unit, "modifier_pride_shaper_pyre", {})
			affected_unit:SetModifierStackCount("modifier_pride_shaper_pyre", caster, affected_unit:GetModifierStackCount("modifier_pride_shaper_pyre", caster) + 1)
		end
		return 0.5
	end)
	Timers:CreateTimer(function()
		if done then
			for _, v in pairs(affected) do
				v:RemoveModifierByName("modifier_pyrebug_burning_bush")
			end
			return
		end
		local applied_to = {}
		for _, bush_point in pairs(bush_points) do
			local hits = GetEnemiesInRadiusOfPoint(bush_point, caster:GetTeamNumber(), 60)

			for _, v in pairs(hits) do
				if not tableContains(affected, v) then
					ability:ApplyDataDrivenModifier(caster, v, "modifier_pyrebug_burning_bush", {})
					affected[#affected + 1] = v
				end
				applied_to[#applied_to + 1] = v
			end
		end

		for k, applied_to_target in pairs(affected) do
			if not tableContains(applied_to, applied_to_target) then
				applied_to_target:RemoveModifierByName("modifier_pyrebug_burning_bush")

				affected[k] = nil
			end
		end

		return 1 / 30
	end)
end