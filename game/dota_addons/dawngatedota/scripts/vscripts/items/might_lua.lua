function gain_stack(event)
	local caster = event.caster

	local might = find_item(caster, "item_might")
    might:ApplyDataDrivenModifier(caster, caster, "modifier_soul_collector", { })	
	local stacks = caster:GetModifierStackCount("modifier_soul_collector", caster)
    if stacks < 30 then
        might:ApplyDataDrivenModifier(caster, caster, "modifier_soul_collector_hidden", {})
    end
	if stacks ~= 0 then
		caster:SetModifierStackCount("modifier_soul_collector", might, math.min(30, stacks + 1))
	else
		caster:SetModifierStackCount("modifier_soul_collector", might, 1)
	end
end

function on_remove(event)
    local caster = event.caster
    Timers:CreateTimer(function() --Wait for combinations to perform before trying to remove stacks
	    local strife_item = find_item(caster, "item_strife")
	    local decay_item = find_item(caster, "item_decay")
	    if not find_item(caster, "item_might") and not find_item(caster, "item_strife") and not find_item(caster, "item_decay") then
	        caster:RemoveModifierByName("modifier_soul_collector")
			while caster:HasModifier("modifier_soul_collector_hidden") do
				caster:RemoveModifierByName("modifier_soul_collector_hidden")
			end
			caster:RemoveModifierByName("modifier_strife_soul_collector")
	    end
	    if strife_item and not find_item(caster, "item_might") then
	    	local might_stacks = caster:GetModifierStackCount("modifier_soul_collector", caster)
	    	caster:RemoveModifierByName("modifier_soul_collector")
			while caster:HasModifier("modifier_soul_collector_hidden") do
				caster:RemoveModifierByName("modifier_soul_collector_hidden")
			end
			strife_item:ApplyDataDrivenModifier(caster, caster, "item_strife_stacking", {})
			strife_item:ApplyDataDrivenModifier(caster, caster, "modifier_strife_soul_collector", {})
			caster:SetModifierStackCount("modifier_strife_soul_collector", caster, might_stacks)
		end
	    if decay_item and not find_item(caster, "item_might") then
	    	local might_stacks = caster:GetModifierStackCount("modifier_soul_collector", caster)
	    	caster:RemoveModifierByName("modifier_soul_collector")
	    	decay_item:ApplyDataDrivenModifier(caster, caster, "modifier_soul_collector_decay", {})
	    	caster:SetModifierStackCount("modifier_soul_collector_decay", decay_item, might_stacks)
			while caster:HasModifier("modifier_soul_collector_hidden") do
				caster:RemoveModifierByName("modifier_soul_collector_hidden")
				decay_item:ApplyDataDrivenModifier(caster, caster, "modifier_soul_collector_hidden_decay", {})
			end
			caster:RemoveModifierByName("modifier_strife_soul_collector")
	    end
	end)
end