--[[
	AddStack(event)
		caster (Handle),
		target (Handle),
		ability (Handle),
		Stacks (Added Stacks, can be negative),
		MaxStacks (Maximum total stacks),
		ModifierName,
		Condition,
		Target (CASTER or TARGET),
		IsUniversalModifier (0, not set, or 1, Uses Universal Ability modifiers instead of ability's modifiers)
		PowerRatio (%power to add to stacks),
		Duration (Duration to add stacks for),
--]]

function AddStacks(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local added_stacks = event.Stacks
	local max_stacks = event.MaxStacks
	local modifier_name = event.ModifierName

	local condition = event.Condition

	if event.Target == "CASTER" then target = caster end

	if condition ~= nil then
		for k, v in pairs(condition) do
			if k == "HasModifierStacks" then
				local condition_modifier_name = v.ModifierName
				local condition_target = v.Target
				if condition_target == "TARGET" then
					condition_target = target
				end
				if condition_target == "CASTER" then
					condition_target = caster
				end
				local condition_ability = v.AbilityName
				if condition_ability == "SELF" or condition_ability == nil then
					condition_ability = ability
				else
					local condition_ability = caster:FindAbilityByName(condition_ability)
				end
				local condition_modifier_stack_min = v.MinStacks
				if condition_modifier_stack_min == nil then condition_modifier_stack_min = 0 end
				local condition_modifier_stack_max = v.MaxStacks
				if condition_modifier_stack_max == nil then condition_modifier_stack_max = 1000000 end
				local condition_current_stacks = condition_target:GetModifierStackCount(condition_modifier_name, nil)
				if not (condition_current_stacks >= condition_modifier_stack_min and
				        condition_current_stacks <= condition_modifier_stack_max) then
					return
				end
			end
		end
	end

	if event.IsUniversalModifier == "True" then
		ability = caster:FindAbilityByName("ability_universal_ability")
	end

	if event.PowerRatio ~= nil then
		added_stacks = added_stacks + event.PowerRatio * find_stat(caster, "power")
	end
	local duration = event.Duration
	if event.DurationPowerRatio ~= nil then
		duration = duration + event.DurationPowerRatio * find_stat(caster, "power")
	end
	ability:ApplyDataDrivenModifier(caster, target, modifier_name, { Duration = duration})
	local total_stacks = math.min(max_stacks, math.max(0, target:GetModifierStackCount(modifier_name, caster) + added_stacks))
	local total_stacks_added = total_stacks - target:GetModifierStackCount(modifier_name, caster)
	target:SetModifierStackCount(modifier_name, caster, total_stacks)
	if target:GetModifierStackCount(modifier_name, caster) == 0 then
		target:RemoveModifierByName(modifier_name)
	else 
		Timers:CreateTimer(duration, function()
			target:SetModifierStackCount(modifier_name, caster, target:GetModifierStackCount(modifier_name, caster) - total_stacks_added)
			if target:GetModifierStackCount(modifier_name, caster) == 0 then
				target:RemoveModifierByName(modifier_name)
			end
		end)
	end
end

function DoPurge(event)
	local target = event.target
	local caster = event.caster
	if event.Target == "CASTER" then target = caster end
	target:Purge(false, true, false, false, false)
	target.finesse_table = { } --Purge finesse debuff
end