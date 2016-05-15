function cast(event)
	local caster = event.caster
	local target = event.caster
	local ability = event.ability
	caster:SetModifierStackCount("modifier_cerulean_armour", caster, event.Defenses * 2)
	ticks = 0
	Timers:CreateTimer(function()
		caster:SetModifierStackCount("modifier_cerulean_armour", caster, event.Defenses * 2 - ticks)
		if ticks == event.Defenses then
			Timers:CreateTimer(2, function()
				caster:RemoveModifierByName("modifier_cerulean_armour")
			end)
			return
		end
		ticks = ticks + 1
		return 2 / event.Defenses
	end)
end