function OnGiantKillerAttackLanded(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target
	local added_damage = 20 + (find_stat(target, "life") + find_stat(target, "health")) * 0.08 + target:GetMaxHealth() * 0.02
	if not target:IsHero() then
		added_damage = math.min(225, added_damage)
	end
	deal_damage(caster, target, added_damage, 0, 1, "RUIN", false, false, false, 0)
end