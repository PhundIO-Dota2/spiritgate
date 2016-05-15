bad_flips = {
	"npc_binding",
	"npc_guardian_good",
	"npc_guardian_bad"
}

function cast(event)
	dofile("deal_damage")

	local caster = event.caster
	local target = event.target_points[1]

	local slows = GetEnemiesInRadiusOfPoint(target, caster:GetTeamNumber(), 260)
	for k, target in pairs(slows) do
		event.ability:ApplyDataDrivenModifier(caster, target, "modifier_mad_king_finale_slow", {})
	end
	Timers:CreateTimer(0.6, function()
		Timers:CreateTimer(0.75, function()
			for k, v in pairs(slows) do
				v:RemoveModifierByName("modifier_mad_king_finale_slow")
				if not tableContains(bad_flips, v:GetUnitName()) then
					FindClearSpaceForUnit(v, target, false)
				end
			end
			local hits = GetEnemiesInRadiusOfPoint(target, caster:GetTeamNumber(), 260)
			for k, v in pairs(hits) do
				deal_damage(caster, v, event.Damage, event.DamagePowerRatio, 2, event.ability, false, false, true)
				if not tableContains(bad_flips, v:GetUnitName()) then
					FindClearSpaceForUnit(v, target, false)
				end
			end
		end)
		local pid = ParticleManager:CreateParticle("particles/kom_finale/finale_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(pid, 0, target)
	end)
end