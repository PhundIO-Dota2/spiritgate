function place_ward(event)
    dofile("deal_damage")
	local caster = event.caster
	local target = event.target_points[1]
	local ability = event.ability
	if (target - caster:GetAbsOrigin()):Length2D() > 900 then
		ability:EndCooldown()
		return
	end
	EmitSoundOnLocationForAllies(target,"dawngatedota.merchant_princess_FinalPaymentCoin",caster)
	local ward = CreateUnitByName("npc_spiritgate_ward", target, true, caster, caster, caster:GetTeamNumber())
	ward:SetAbsOrigin(ward:GetAbsOrigin())
	ward:AddNewModifier(caster, nil, "modifier_invulnerable", {})
	ward:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(ward, ward, "modifier_dummy_unit", {})
	ward:SetHullRadius(0)
	ward:SetForwardVector(Vector(0, -1, 0))
	Timers:CreateTimer(60, function()
		ward:Kill(event.ability, caster)
	end) 
	Timers:CreateTimer(1.5, function()
		ward:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(ward, ward, "modifier_spiritgate_ward_invisible", {})
	end)

	ParticleManager:CreateParticle("particles/spward/ward_base.vpcf", PATTACH_ABSORIGIN, ward)
end