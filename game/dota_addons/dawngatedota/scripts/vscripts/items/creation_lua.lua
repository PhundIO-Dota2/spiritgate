--Lifedrain and Heal managed in deal_damage

function OnCreated(event)
	local caster = event.caster
	local item = event.ability
	caster.creation_running = true
	Timers:CreateTimer(function()
		if caster.creation_running == false then return end
		local heal_amount = caster:GetHealthRegen() / 30 * 0.3
		caster:SetHealth(math.min(caster:GetMaxHealth(), caster:GetHealth() + heal_amount))
		return 1 / 30
	end)
end
function OnDestroy(event)
	local caster = event.caster
	local item = event.ability
	caster.creation_running = false
end