function AttackLanded(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	if caster.grievous ~= "never" then
		if ability.attack_num == nil then
			ability.attack_num = 0
		end
		ability.attack_num = ability.attack_num + 1

		if ability.attack_num >= 2 then
			apply_wounds(ability, caster)
		end

		if (caster.grievous == "always" or ability.attack_num >= 3) then
			ability.attack_num = 0
			dofile("deal_damage")
			local damage = caster:GetMaxHealth()
			damage = damage * ((event.Damage + event.DamagePowerRatio * find_stat(caster, "power")) / 100)
			deal_damage(caster, target, damage, 0, 2, ability, false, false, false)
			if caster.grievous ~= "always" then
				remove_wounds(ability, caster)
			end
		end
	end
end

function cast(event)
	local caster = event.caster
	local ability = event.ability
	caster.grievous = "always"
	apply_wounds(ability, caster)
	Timers:CreateTimer(8, function()
		caster.grievous = "never"
		remove_wounds(ability, caster)
		ability.attack_num = 0
		Timers:CreateTimer(ability:GetCooldownTimeRemaining(), function()
			caster.grievous = nil
		end)
	end)
end

function apply_wounds(ability, caster)
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_greivous_wound_up", {})
end

function remove_wounds(ability, caster)
	caster:RemoveModifierByName("modifier_greivous_wound_up")
end