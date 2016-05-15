function cast(event)
	local caster = event.caster
	local target = event.target

	local allHits = {}

	dofile("deal_damage")

	Timers:CreateTimer(function()
		local fv = (target:GetAbsOrigin() - caster:GetAbsOrigin()):Normalized()
		caster:SetAbsOrigin(caster:GetAbsOrigin() + fv * 40)

		local hits = GetEnemiesInRadiusOfPoint(caster:GetAbsOrigin(), caster:GetTeamNumber(), 140)
		for _, v in pairs(hits) do
			if v ~= target and not tableContains(allHits, v) then
				allHits[#allHits + 1] = v
				deal_damage(caster, v, event.SecondaryDamage, event.SecondaryDamagePowerRatio, 1, event.ability, false, false, true)
				knockback_unit(v, v:GetAbsOrigin(), event.SecondaryKnockupDuration, 0, 350, true)
			end
		end

		if (caster:GetAbsOrigin() - target:GetAbsOrigin()):Length2D() < 40 then
			FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), false)

			deal_damage(caster, target, event.Damage, event.PowerRatio, 1, event.ability, false, false, true)
			disable({
				caster=caster,
				target=target,
				Duration=event.StunDuration,
				DisableModifier="modifier_shepherd_titanic_charge_stun",
				ability=event.ability
			})
			return
		end
		return 0.03
	end)
end