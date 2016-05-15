function tick_gale(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	if caster:FindAbilityByName("ability_elegant_dancer_stance_dance"):GetLevel() == 0 then
		if ability.current_pid_name ~= "particles/ashabel_radius/asha750.vpcf" then
			if ability.pid ~= nil then
				ParticleManager:DestroyParticle(ability.pid, true)
			end
			ability.pid = ParticleManager:CreateParticleForPlayer("particles/ashabel_radius/asha750.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster, caster:GetPlayerOwner())
			ability.current_pid_name = "particles/ashabel_radius/asha750.vpcf"
		end
	elseif caster:GetAbilityByIndex(1):GetAbilityName() == "ability_elegant_dancer_stance_dance" then
		if ability.current_pid_name ~= "particles/ashabel_radius/asha900.vpcf" then
			if ability.pid ~= nil then
				ParticleManager:DestroyParticle(ability.pid, true)
			end
			ability.pid = ParticleManager:CreateParticleForPlayer("particles/ashabel_radius/asha900.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster, caster:GetPlayerOwner())
			ability.current_pid_name = "particles/ashabel_radius/asha900.vpcf"
		end
	else
		if ability.current_pid_name ~= "particles/ashabel_radius/asha500.vpcf" then
			if ability.pid ~= nil then
				ParticleManager:DestroyParticle(ability.pid, true)
			end
			ability.pid = ParticleManager:CreateParticleForPlayer("particles/ashabel_radius/asha500.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster, caster:GetPlayerOwner())
			ability.current_pid_name = "particles/ashabel_radius/asha500.vpcf"
		end
	end
end