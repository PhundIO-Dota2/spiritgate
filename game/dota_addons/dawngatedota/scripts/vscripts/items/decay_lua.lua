function decay(event)
	local caster = event.caster
	local target = event.target
	local item = event.ability
	dofile("deal_damage")
	local damage = target:GetMaxHealth() * 0.06 / 30
	target.decay_taken = target.decay_taken + damage
	if target:IsHero() or target.decay_taken < 320 then
		deal_damage(caster, target, damage, 0, 2, nil, true, false, false)
	end
end

function gain_stack(event)
	local caster = event.caster

	local might = event.ability
    might:ApplyDataDrivenModifier(caster, caster, "modifier_soul_collector_decay", { })	
	local stacks = caster:GetModifierStackCount("modifier_soul_collector_decay", caster)
    if stacks < 30 then
        might:ApplyDataDrivenModifier(caster, caster, "modifier_soul_collector_hidden_decay", {})
    end
	if stacks ~= 0 then
		caster:SetModifierStackCount("modifier_soul_collector_decay", might, math.min(30, stacks + 1))
	else
		caster:SetModifierStackCount("modifier_soul_collector_decay", might, 1)
	end
end

function on_remove(event)
    local caster = event.caster
    Timers:CreateTimer(function() --Wait for combinations to perform before trying to remove stacks
	    local decay_item = find_item(caster, "item_decay")
	    if not decay_item then
	    	caster:RemoveModifierByName("modifier_soul_collector_decay")
	    	caster.strife_health_bonuses = 0
	    	while caster:HasModifier("modifier_soul_collector_hidden_decay") do
	    		caster:RemoveModifierByName("modifier_soul_collector_hidden_decay")
	    	end
	    end
    end)
end