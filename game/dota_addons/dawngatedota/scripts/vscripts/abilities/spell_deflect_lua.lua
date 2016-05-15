function cast(event)
	local caster = event.caster
	local ability = event.ability

	local targets = GetFriendliesInRadiusOfPoint(caster:GetAbsOrigin(), caster:GetTeamNumber(), event.Radius)

	for k, target in pairs(targets) do
		if target:IsHero() then
			ability:ApplyDataDrivenModifier(caster, target, "modifier_deflect", {})
			target:SetModifierStackCount("modifier_deflect", caster, caster:GetLevel() * event.ShieldPerLevel + event.BaseShield)
		end
	end
end