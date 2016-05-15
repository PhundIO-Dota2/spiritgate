function attack_landed(event)
	local ability = event.ability
	local caster = event.caster
	local target = event.target

	caster:SetMana(caster:GetMana() + 10)
	if target:IsHero() then
		caster:SetMana(caster:GetMana() + 10)
	end
	if caster:HasModifier("modifier_focus_shaper_double_edge_damage") then
		caster:SetMana(caster:GetMana() + 10)

		caster:RemoveModifierByName("modifier_focus_shaper_double_edge_damage")
	else
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_focus_shaper_double_edge_damage", {})
	end
end