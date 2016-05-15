function AttackLanded(event)
	dofile("deal_damage")

	local caster = event.caster
	local target = event.target
	local fv = -(caster:GetAbsOrigin() - target:GetAbsOrigin()):Normalized()

	--create_spine(target, caster, fv, math.pi / 2)
	create_spine(target, caster, fv, math.pi / 2)
	create_spine(target, caster, fv, math.pi / 2 + 0.3)
	create_spine(target, caster, fv, math.pi / 2 + 0.6)
	create_spine(target, caster, fv, math.pi / 2 - 0.3)
	create_spine(target, caster, fv, math.pi / 2 - 0.6)

	local hits = GetFriendliesInCone(target, 200, fv, 2.5)
	for _, hit in ipairs(hits) do
		if hit:GetTeamNumber() ~= caster:GetTeamNumber() then
			deal_damage(caster, hit, caster:GetAttackDamage() * 0.65, 0, 1, nil, false, false, true)
		end
	end
end

function create_spine(target, caster, fv, rotation)
	local root_angle = -math.atan2(fv.x, fv.y)

	local new_fv = Vector(math.cos(root_angle + rotation), math.sin(root_angle + rotation), 0)

	local pid = ParticleManager:CreateParticle("particles/vex_splintering_spines/splintering_spines_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, target:GetAbsOrigin())
	local pos = target:GetAbsOrigin()
	ParticleManager:SetParticleControlForward(pid, 0, new_fv)

	local lifetime = 10

	Timers:CreateTimer(function()
		pos = pos + new_fv * 30
		ParticleManager:SetParticleControl(pid, 0, pos)

		lifetime = lifetime - 1

		if lifetime <= 0 then
			ParticleManager:DestroyParticle(pid, true)
			return
		end
		return 1 / 30
	end)
end