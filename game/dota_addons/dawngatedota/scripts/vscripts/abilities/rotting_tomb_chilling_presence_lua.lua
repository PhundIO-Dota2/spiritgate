function cast(event)
	local caster = event.caster
	StartAnimation(caster, { duration=0.5, activity=ACT_DOTA_CAST_ABILITY_2, rate=1 }) 
end