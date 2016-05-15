function tick_haste_bonus(event)
	local caster = event.caster
	local ability = event.ability
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_high_huntress_chase_haste_bonus", {})
	caster:SetModifierStackCount("modifier_high_huntress_chase_haste_bonus", ability, ability:GetLevel())
end

function cast(event)
	local caster = event.caster
	local ability = event.ability

	ability:ApplyDataDrivenModifier(caster, caster, "modifier_high_huntress_the_chase_movespeed_hidden", {})
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_high_huntress_the_chase_movespeed", {})
	caster:SetModifierStackCount("modifier_high_huntress_the_chase_movespeed_hidden", ability, 60)
	Timers:CreateTimer(function()
		local stacks = caster:GetModifierStackCount("modifier_high_huntress_the_chase_movespeed_hidden", ability)
		if stacks == 0 then
			return nil
		else
			caster:SetModifierStackCount("modifier_high_huntress_the_chase_movespeed_hidden", ability, stacks - 1)
		end
		return 1 / 20
	end)
	local isPlaying = false
	Timers:CreateTimer(function()
		local stacks = caster:GetModifierStackCount("modifier_high_huntress_the_chase_movespeed_hidden", ability)
		if stacks == 0 then
			return nil
		end
		if not caster:IsIdle() and not caster:IsAttacking() then
			if not isPlaying then
				StartAnimation(caster, {duration=1, activity=ACT_DOTA_RUN, translate = "haste", rate=1.2})
				Timers:CreateTimer(1 - 1 / 30, function()
					isPlaying = false
				end)
			end
			isPlaying = true
		else
			EndAnimation(caster)
			isPlaying = false
		end
		return 1 / 30
	end)
	Timers:CreateTimer(function()
		local stacks = caster:GetModifierStackCount("modifier_high_huntress_the_chase_movespeed_hidden", ability)
		if stacks == 0 then
			return nil
		end
		if not caster:IsIdle() then
			local pid = ParticleManager:CreateParticle("particles/nissa_the_chase/nissa_the_chase_footsteps.vpcf", PATTACH_ABSORIGIN, caster)
		end
		return 1 / 15
	end)
end

function on_attack(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_high_huntress_the_chase_refresh", {})
	if count_modifiers(caster, "modifier_high_huntress_the_chase_refresh") < 4 then
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_high_huntress_the_chase_movespeed_hidden", {})
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_high_huntress_the_chase_movespeed", {})
		caster:SetModifierStackCount("modifier_high_huntress_the_chase_movespeed_hidden", ability, 60)
	end
	caster:SetMana(caster:GetMana() + 10)
end