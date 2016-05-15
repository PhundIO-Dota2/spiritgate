function cast(event)
	local caster = event.caster
	local ability = event.ability
	ability:ApplyDataDrivenModifier(caster, caster , "modifier_bastion_shield", {})
	caster:SetModifierStackCount("modifier_bastion_shield", caster, event.BaseShield + event.ShieldPerLevel * caster:GetLevel())
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_bastion_resists", {})
	Timers:CreateTimer(function()
		if not caster:HasModifier("modifier_bastion_shield") then
			caster:RemoveModifierByName("modifier_bastion_resists")
			return
		end
		return 1 / 30
	end)
end