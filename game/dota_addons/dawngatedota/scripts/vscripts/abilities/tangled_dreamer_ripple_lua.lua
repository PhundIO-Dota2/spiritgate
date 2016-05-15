function cast(event)
	local caster = event.caster
	local target = event.target
	local enemies = GetEnemiesInRadiusOfPoint(target:GetAbsOrigin(), caster:GetTeamNumber(), 300)
	for _, v in ipairs(enemies) do
		if v ~= target then
			knockback_unit(v, target:GetAbsOrigin(), 0.25, 100, 100, true)
		end
	end
	if caster:GetTeamNumber() == target:GetTeamNumber() then
		return cast_ally(event)
	end
	return cast_enemy(event)
end

function cast_ally(event)
	local caster = event.caster
	local target = event.target

	require("modifier_helper")
	DoPurge(event)
end

function cast_enemy(event)
	local caster = event.caster
	local target = event.target

	dofile("deal_damage")
	deal_damage(caster, target, event.Damage, event.DamagePowerRatio, 2, event.ability, false, false, false)
	event.ability:ApplyDataDrivenModifier(caster, target, "modifier_dreamer_ripple_slow", {})
	local initial_stacks = -event.MovementSpeedReduction
	local total_stacks_adjusted = initial_stacks
	target:SetModifierStackCount("modifier_dreamer_ripple_slow", caster, initial_stacks)
	
	Timers:CreateTimer(function()
		total_stacks_adjusted = total_stacks_adjusted - initial_stacks / 2.5 / 30
		target:SetModifierStackCount("modifier_dreamer_ripple_slow", caster, total_stacks_adjusted)
		if total_stacks_adjusted < 0 then
			return
		end
		return 1 / 30
	end)
end