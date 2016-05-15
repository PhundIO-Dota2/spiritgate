bad_flips = {
	"npc_binding",
	"npc_guardian_good",
	"npc_guardian_bad"
}


function cerulean_impale(event)
	if tableContains(bad_flips, event.target:GetUnitName()) then
		return
	end
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local casterPos = caster:GetAbsOrigin()
	local targetPos = target:GetAbsOrigin()
	local tx = casterPos.x - targetPos.x
	local ty = casterPos.y - targetPos.y
	local length = math.sqrt(math.pow(tx, 2) + math.pow(ty, 2)) --I have no idea how to create a vector with lua, replace this with vector logic
	targetPos.x = casterPos.x + tx / length * 200
	targetPos.y = casterPos.y + ty / length * 200

	local ticks = 0
	local pid = ParticleManager:CreateParticle("particles/warden/impale_trail.vpcf", PATTACH_CUSTOMORIGIN, target)

	ability:ApplyDataDrivenModifier(caster, target, "modifier_impale_rooted", {})

	Timers:CreateTimer(function()
		ticks = ticks + 1

		if ticks <= 4 then
			target:SetAbsOrigin(target:GetAbsOrigin() + Vector(0, 0, (8 - ticks * 3) + 100))
		else
			target:SetAbsOrigin(target:GetAbsOrigin() + Vector(0, 0, -ticks * 0.5 - 34))
		end

		target:SetAbsOrigin((target:GetAbsOrigin() * 4 + targetPos) / 5)

		ParticleManager:SetParticleControl(pid, 0, target:GetAbsOrigin())

		if math_distance(target:GetAbsOrigin(), targetPos) < 50 then
			FindClearSpaceForUnit(target, targetPos, true)
			ParticleManager:DestroyParticle(pid, false)
			target:RemoveModifierByName("modifier_impale_rooted")
			return nil
		end
		return 1 / 30
	end)
end