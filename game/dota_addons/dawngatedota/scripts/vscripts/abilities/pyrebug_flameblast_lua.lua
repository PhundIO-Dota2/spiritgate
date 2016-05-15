function cast(event)
	local caster = event.caster
	local target = event.target_points[1]
	local ability = event.ability

	ability.pid = ParticleManager:CreateParticle("particles/pyrebug/flameblast.vpcf", PATTACH_CUSTOMORIGIN, nil)

	ParticleManager:SetParticleControl(ability.pid, 0, target)
	ParticleManager:SetParticleControl(ability.pid, 1, Vector(0.0001, 0, 0))

	ability.scale = 1 / 30

	ability.timer = Timers:CreateTimer(function()
		ability.scale = ability.scale + 1 / (event.ChannelTime + 1) / 30

		ParticleManager:SetParticleControl(ability.pid, 1, Vector(ability.scale, 0, 0))

		if ability.scale >= 1 then
			return
		end

		return 1 / 30
	end)
end

function release(event)
	dofile("deal_damage")

	local caster = event.caster
	local target = event.target_points[1]
	local ability = event.ability

	local pride_shaper = caster:FindAbilityByName("ability_pride_shaper")

	ParticleManager:DestroyParticle(ability.pid, true)
	ability.pid = nil
	Timers:RemoveTimer(ability.timer)

	local hits = GetEnemiesInRadiusOfPoint(target, caster:GetTeamNumber(), 500 * ability.scale)
	for _, hit in pairs(hits) do
		local pyre_stacks = math.floor(event.PyreStacksMaximum * ability.scale)
		local damage = event.Damage * ability.scale
		local damage_power_ratio = event.DamagePowerRatio * ability.scale

		deal_damage(caster, hit, damage, damage_power_ratio, 2, event.ability, false, false, true)

		pride_shaper:ApplyDataDrivenModifier(caster, hit, "modifier_pride_shaper_pyre", {})
		hit:SetModifierStackCount("modifier_pride_shaper_pyre", caster, hit:GetModifierStackCount("modifier_pride_shaper_pyre", caster) + pyre_stacks)
	end
end