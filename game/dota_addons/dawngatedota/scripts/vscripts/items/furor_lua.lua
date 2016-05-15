function attack_landed(event)
	local caster = event.caster
	local target = event.target

	local chance = RandomInt(1, 8)

	if chance == 1 then
		StartAnimation(caster, { duration=1, activity=ACT_DOTA_ATTACK, rate=2 }) 
		caster:PerformAttack(target, true, true, true, true)
	end
end