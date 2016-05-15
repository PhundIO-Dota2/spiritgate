function cast(event)
	dofile("deal_damage")
	local caster = event.caster
	local targets = GetEnemiesInRadius(caster, event.Radius)
	local ability = event.ability

	for k, target in ipairs(targets) do
		local damage = event.Damage + find_stat(caster, "power") * event.DamagePowerRatio
		local stacks = target:GetModifierStackCount("modifier_spirit_sand", caster)
		damage = damage + stacks * event.StackDamage + event.StackDamagePowerRatio * find_stat(caster, "power")
		deal_damage(caster, target, damage, 0, 1, ability, false, false, true)

		ability:ApplyDataDrivenModifier(caster, target, "modifier_spirit_sand", {})
		target:SetModifierStackCount("modifier_spirit_sand", caster, stacks + 1)
	end
end

function tick_spirit_sand(event)
	local caster = event.caster
	local target = event.target
	if not target.spirit_sand_pids then
		target.spirit_sand_pids = {}
	end
	if target.spirit_sand_rotation == nil then target.spirit_sand_rotation = 0 end
	target.spirit_sand_rotation = target.spirit_sand_rotation + 0.05

	for i=1, target:GetModifierStackCount("modifier_spirit_sand", caster) do
		if not target.spirit_sand_pids[i] then
			target.spirit_sand_pids[i] = ParticleManager:CreateParticle("particles/kahgen_dust_devil/dust_devil_debuff_base.vpcf", PATTACH_CUSTOMORIGIN, target)
			local index = i
			function get_target_pos(target, index, yoff)
				local stacks = target:GetModifierStackCount("modifier_spirit_sand", caster)
				local angle_offset = math.pi * 2 / stacks
				return target:GetAbsOrigin() + Vector(math.cos(index * angle_offset + target.spirit_sand_rotation) * 120, math.sin(index * angle_offset + target.spirit_sand_rotation) * 120, 160 + yoff)
			end
			local yoff = RandomInt(-30, 30)
			local current_pos = get_target_pos(target, index, yoff)
			
			Timers:CreateTimer(function()
				if #target.spirit_sand_pids == 0 or target:IsNull() then return end
				local next_pos = (current_pos + get_target_pos(target, index, yoff)) / 2
				ParticleManager:SetParticleControl(target.spirit_sand_pids[i], 0, next_pos)
				current_pos = next_pos
				return 1 / 30
			end)
		end
	end
	target.last_spirit_sand_stack_count = stacks
end

function on_destroyed(event)
	print("DED")

	local caster = event.caster
	local target = event.target	

	for k, v in ipairs(target.spirit_sand_pids) do
		ParticleManager:DestroyParticle(v, false)
	end
	target.spirit_sand_pids = {}
end