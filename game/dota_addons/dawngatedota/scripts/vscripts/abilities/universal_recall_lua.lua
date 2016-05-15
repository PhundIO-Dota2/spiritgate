local spell = {}

function spell.cast(event)
	local caster = event.caster

	event.ability.pid = ParticleManager:CreateParticle("particles/fountain_tele/fountain_tele_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(event.ability.pid, 0, caster:GetAbsOrigin())

	caster:Stop()
end

function spell.on_finish(event)
	local caster = event.caster
	ParticleManager:DestroyParticle(event.ability.pid, false)

	local target = Entities:FindByName(nil, "recall_" .. caster:GetTeamNumber()):GetAbsOrigin()
	FindClearSpaceForUnit(caster, target, false)
end

function spell.on_cancel(event)
	local caster = event.caster
	ParticleManager:DestroyParticle(event.ability.pid, false)
end

return spell