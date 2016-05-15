function tick(event)
	local caster = event.caster
	caster.health_shaper_pulse_effectiveness = 1 + .25 * (caster:GetHealth() / caster:GetMaxHealth())
end