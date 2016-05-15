function gain_stack(event)
	local caster = event.caster
	local item = event.ability

    item:ApplyDataDrivenModifier(caster, caster, "item_strife_stacking", { })	
    item:ApplyDataDrivenModifier(caster, caster, "item_strife_power_bonus", { })
    if caster.strife_health_bonuses == nil then
    	caster.strife_health_bonuses = 0
    end
	local stacks = caster:GetModifierStackCount("item_strife_stacking", caster)
    stacks = stacks + 1
    caster:SetModifierStackCount("item_strife_stacking", caster, stacks)
    local target_power = 0
    local target_health = 0
    local bonus_power_per = 0.25
    local bonus_health_per = 3
    for i=0, stacks do
    	target_power = target_power + bonus_power_per
    	target_health = target_health + bonus_health_per
    	bonus_power_per = bonus_power_per * 0.995
    	bonus_health_per = bonus_health_per * 0.995
    end
    caster:SetModifierStackCount("item_strife_power_bonus", caster, target_power)
    while caster.strife_health_bonuses < target_health do
    	item:ApplyDataDrivenModifier(caster, caster, "item_strife_health_bonus", {})
    	caster.strife_health_bonuses = caster.strife_health_bonuses + 1
    end	
end

function on_remove(event)
    local caster = event.caster
    Timers:CreateTimer(function() --Wait for combinations to perform before trying to remove stacks
	    local strife_item = find_item(caster, "item_strife")
	    if not strife_item then
	    	caster:RemoveModifierByName("item_strife_stacking")
	    	caster.strife_health_bonuses = 0
	    	while caster:HasModifier("modifier_strife_health_bonus") do
	    		caster:RemoveModifierByName("modifier_strife_health_bonus")
	    	end
	    	caster:RemoveModifierByName("item_strife_power_bonus")
	    end
    end)
end