function cast(event)
	local caster = event.caster
	local target = event.target

	local flash_pid = ParticleManager:CreateParticle("particles/kindra_shadowstep/shadowstep_flash.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(flash_pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 50))

	local endpos = target:GetAbsOrigin() - target:GetForwardVector() * 100
	FindClearSpaceForUnit(caster, endpos, false)
	caster:SetForwardVector(target:GetForwardVector())

	flash_pid = ParticleManager:CreateParticle("particles/kindra_shadowstep/shadowstep_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(flash_pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 150))

	if target:GetTeamNumber() ~= caster:GetTeamNumber() then
		dofile("deal_damage")
		deal_damage(caster, target, event.Damage, event.DamagePowerRatio, 2, event.ability, false, false, false)
	end
end