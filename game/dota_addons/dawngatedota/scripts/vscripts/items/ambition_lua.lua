function on_equip(event)
	local caster = event.caster
	local item = event.ability
	item.active = true
	Timers:CreateTimer(function()
		if not item.active then return end
		local stacks = (caster:GetMaxHealth() - caster:GetHealth()) / caster:GetMaxHealth() * 10
		if stacks > 0 then
			item:ApplyDataDrivenModifier(caster, caster, "modifier_ambition_stack", {})
			caster:SetModifierStackCount("modifier_ambition_stack", caster, stacks)	
		else
			caster:RemoveModifierByName("modifier_ambition_stack")
		end
		return 0.1
	end)
end
function on_unequip(event)
	local item = event.ability
	item.active = false
end