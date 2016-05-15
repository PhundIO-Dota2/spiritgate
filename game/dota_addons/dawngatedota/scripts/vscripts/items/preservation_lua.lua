function OnCreated(event)
	local caster = event.caster
	local item = event.ability
	caster.preservation_running = true
	Timers:CreateTimer(function()
		if caster.preservation_running == false then return end
		if not caster:HasModifier("universal_in_combat") then
			item:ApplyDataDrivenModifier(caster, caster, "modifier_ablative_armour", {})
			caster:SetModifierStackCount("modifier_ablative_armour", caster, 5)	
		end
		if caster:GetModifierStackCount("modifier_ablative_armour", caster) == 0 then
			caster:RemoveModifierByName("modifier_ablative_armour")
		end
		return 1 / 30
	end)
end
function OnDestroy(event)
	local caster = event.caster
	local item = event.ability
	caster.preservation_running = false
	caster:RemoveModifierByName("modifier_ablative_armour")
end