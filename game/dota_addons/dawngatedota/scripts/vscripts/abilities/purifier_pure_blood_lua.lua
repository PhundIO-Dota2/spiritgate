function cast(event)
	dofile("deal_damage")

	local caster = event.caster

	if caster:GetModifierStackCount("modifier_purifier_blood_orb", caster) < 1 then
		return
	end
	caster:SetModifierStackCount("modifier_purifier_blood_orb", caster, caster:GetModifierStackCount("modifier_purifier_blood_orb", caster) - 1)

	local target = event.target_points[1]
	local ability = event.ability

	local pid = ParticleManager:CreateParticle("particles/viyanna_pure_blood/pure_blood_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	local pos = caster:GetAbsOrigin()
	local spd = 20
	local fv = (target - caster:GetAbsOrigin()):Normalized()
	ParticleManager:SetParticleControl(pid, 0, pos + Vector(0, 0, 50))
	Timers:CreateTimer(function()
		pos = pos + spd * fv
		ParticleManager:SetParticleControl(pid, 0, pos + Vector(0, 0, 50))
		if (pos - target):Length2D() <= spd * 1.1 then
			ParticleManager:DestroyParticle(pid, false)
			local pid = ParticleManager:CreateParticle("particles/viyanna_pure_blood/pure_blood_explosion_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
			ParticleManager:SetParticleControl(pid, 0, pos + Vector(0, 0, 50))

			local hits = GetEnemiesInRadiusOfPoint(pos, caster:GetTeamNumber(), 100)
			for k, hit in pairs(hits) do
				local damage_mult = 1
				if hit.pure_blood_modifier_ticker ~= nil then
					damage_mult = 0.6
				end
				deal_damage(caster, hit, event.Damage * damage_mult, event.DamagePowerRatio * damage_mult, 2, ability, false, false, true)
				hit.pure_blood_modifier = (100 + event.ReducedHealing) * 0.01
				if hit.pure_blood_modifier_ticker ~= nil then
					Timers:RemoveTimer(hit.pure_blood_modifier_ticker)
				end
				hit.pure_blood_modifier_ticker = Timers:CreateTimer(3, function()
					hit.pure_blood_modifier = nil
					hit.pure_blood_modifier_ticker = nil
				end)
			end

			return
		end
		return 1 / 30
	end)
end

function add_blood_orb(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local new_count = math.min(5, caster:GetModifierStackCount("modifier_purifier_blood_orb", caster) + 1)
	caster:SetModifierStackCount("modifier_purifier_blood_orb", caster, new_count)
end

function tick_blood_orbs(event)
	local caster = event.caster
	local ability = event.ability
	if ability.recent_targets == nil then
		ability.recent_targets = {}
	end

	local targets = GetFriendyHeroesInRadiusOfPointClosest(caster:GetAbsOrigin(), caster:GetTeamNumber(), 1200)

	dofile("deal_damage")

	for k, v in pairs(targets) do
		if k >= 2 then
			if not tableContains(ability.recent_targets, v) and v:GetHealth() < v:GetMaxHealth() * 0.3 then
				if caster:GetModifierStackCount("modifier_purifier_blood_orb", caster) > 1 then
					local new_count = math.max(0, caster:GetModifierStackCount("modifier_purifier_blood_orb", caster) - 1)
					caster:SetModifierStackCount("modifier_purifier_blood_orb", caster, new_count)

					local index = #ability.recent_targets + 1
					ability.recent_targets[#ability.recent_targets + 1] = v
					Timers:CreateTimer(15, function()
						ability.recent_targets[index] = nil
					end)
					
					local pid = ParticleManager:CreateParticle("particles/purity/purityblob_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
					local pos = caster:GetAbsOrigin()
					ParticleManager:SetParticleControl(pid, 0, pos)
					Timers:CreateTimer(function()
						pos = pos + (v:GetAbsOrigin() - pos):Normalized() * 36
						ParticleManager:SetParticleControl(pid, 0, pos + Vector(0, 0, 100))
						if (pos - v:GetAbsOrigin()):Length2D() < 50 then
							deal_damage_heal(caster, v, event.Heal, 0, event.HealHealthRatio)
							ParticleManager:DestroyParticle(pid, false)
							return
						end
						return 1 / 30
					end)
				end
			end
		end
	end	
end