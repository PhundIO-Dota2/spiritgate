function attack_landed(event)
	dofile('deal_damage')
	local caster = event.caster
	local target = event.target

	local targets = GetEnemiesInRadiusOfPoint(target:GetAbsOrigin(), caster:GetTeamNumber(), 300)
	local hits = 0
	for _, enemy in ipairs(targets) do
		if enemy ~= target then
			hits = hits + 1
			if hits > 3 then
				break
			end
			local pid = ParticleManager:CreateParticle("particles/econ/items/clockwerk/clockwerk_paraflare/clockwerk_para_rocket_flare_sparks.vpcf", PATTACH_CUSTOMORIGIN, nil)
			local pos = target:GetAbsOrigin()
			Timers:CreateTimer(function()
				if (pos - enemy:GetAbsOrigin()):Length2D() > 26 then
					pos = pos - (pos - enemy:GetAbsOrigin()):Normalized() * 26
					ParticleManager:SetParticleControl(pid, 3, pos + Vector(0, 0, 150))
					return 1 / 30
				end
				ParticleManager:DestroyParticle(pid, false)
				local damage = GetBasicAttackDamage(caster) * 0.4 + find_stat(caster, "precision")
				deal_damage(caster, enemy, damage, 0, 1, "FATE", false, false, false)
				return
			end)
		end
	end
end