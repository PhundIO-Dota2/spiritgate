function check_target(event)
	local target = event.target
	print(target:GetUnitName())
	if target.is_jungle_creep or
	       target:GetUnitName() == "npc_creep_melee" or 
	       target:GetUnitName() == "npc_creep_ranged" or 
	       target:GetUnitName() == "npc_well_worker" then
       return
	end
	Notifications:Bottom(event.caster:GetMainControllingPlayer(), {text="Can only be cast on jungle creeps, minions, and workers", style={color="red"}})
	event.caster:Interrupt()
end

function cast(event)
	local caster = event.caster
	local target = event.target

	local damage = event.BaseDamage + event.DamagePerLevel * caster:GetLevel()

	local damage_table = {}
	damage_table.attacker = caster
	damage_table.victim = target
	damage_table.damage_type = 1
	damage_table.ability = event.ability	
	damage_table.damage = damage

	ApplyDamage(damage_table)

	local pid = ParticleManager:CreateParticle("particles/spell_vanquish/vanquish_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, target:GetAbsOrigin())
end