function cast(event)
	local caster = event.caster

	caster.current_channeled_ability = event

	if event.CancelOnDamage then
		caster:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(caster, caster, "channeling_ability_modifier", {Duration = event.Duration})
	end
	if event.CancelOnAction then
		caster:Interrupt()
	end

	local scriptfile = require(event.FunctionFile)
	scriptfile[event.OnCast](event)
	caster.current_channeled_timer = Timers:CreateTimer(event.Duration, function()
		scriptfile[event.OnFinish](event)
		caster:RemoveModifierByName("channeling_ability_modifier")
		caster.current_channeled_timer = nil
		caster.current_channeled_ability = nil
	end)
end

function Interrupt(event)
	local caster = event.caster
	local scriptfile = require(caster.current_channeled_ability.FunctionFile)

	caster:RemoveModifierByName("channeling_ability_modifier")
	Timers:RemoveTimer(caster.current_channeled_timer)
	caster.current_channeled_timer = nil

	scriptfile[caster.current_channeled_ability.OnCancel](caster.current_channeled_ability)
	caster:RemoveModifierByName("channeling_ability_modifier")

	caster.current_channeled_ability = nil
end

local mod = {}
function mod.Interrupt(event)
	Interrupt(event)
end
return mod