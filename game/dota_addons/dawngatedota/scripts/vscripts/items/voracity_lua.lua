function VoracityAttackLanded(event)
	local caster = event.caster
	local item = event.ability
	item:ApplyDataDrivenModifier(caster, caster, "modifier_voracity_stack", {})
	caster:SetModifierStackCount("modifier_voracity_stack", caster, math.min(5, caster:GetModifierStackCount("modifier_voracity_stack", caster) + 1))
end