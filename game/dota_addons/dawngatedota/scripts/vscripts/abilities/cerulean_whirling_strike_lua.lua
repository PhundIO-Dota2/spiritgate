function cast(event)
	local caster = event.caster
	StartAnimation(caster, { duration=0.9, activity=ACT_DOTA_CAST_ABILITY_3, rate=1 }) 
end