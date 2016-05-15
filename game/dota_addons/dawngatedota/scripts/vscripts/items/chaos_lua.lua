function OnChaosAttackLanded(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target
	local item = event.ability
	if not caster:HasModifier("modifier_chaos_cooldown") then
		--deal_damage(caster, target, 75 + GetBasicAttackDamage(caster), 0, 2, event.ability, false, false, true)

		local blacklist = { target }

		for i=1, 4 do
			local targets = GetEnemiesInRadiusOfPoint(target:GetAbsOrigin(), caster:GetTeamNumber(), 400)

			for k, v in ipairs(targets) do
				if tableContains(blacklist, v) then 
					tableRemove(targets, v)
				end
			end

			if #targets > 0 then
				local pid = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf", PATTACH_CUSTOMORIGIN, caster)
				
				local found_unit = false
				for k, v in ipairs(targets) do
					if v:IsHero() then found_unit = v end
				end
				found_unit = targets[RandomInt(1, #targets)]
				ParticleManager:SetParticleControl(pid, 1, target:GetAbsOrigin() + Vector(0, 0, 100))
				ParticleManager:SetParticleControl(pid, 0, found_unit:GetAbsOrigin() + Vector(0, 0, 100))
				
				deal_damage(caster, found_unit, 75 + GetBasicAttackDamage(caster) * 0.1, 0, 2, event.ability, false, false, true)
				
				target = found_unit
				blacklist[#blacklist + 1] = target

				item:ApplyDataDrivenModifier(caster, target, "modifier_chaos_magic_damage_increased", {})
				item:ApplyDataDrivenModifier(caster, caster, "modifier_chaos_cooldown", {})
			end
		end
	end
end