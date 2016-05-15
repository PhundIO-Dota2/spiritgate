ANIM_END_POINT = 0.6

if ability_universal_attack == nil then
	ability_universal_attack = class({})
end

function ability_universal_attack:OnAbilityPhaseStart()
	return true
end

function ability_universal_attack:OnAbilityPhaseInterrupted()
	EndAnimation(self:GetCaster())
end

function ability_universal_attack:OnSpellStart()
	if self.attack_cooldown_timer ~= nil or self:GetCaster().preattack_timer ~= nil then
		return false
	end	
	if self:GetCursorTarget():GetTeamNumber() == self:GetCaster():GetTeamNumber() then 
		return
	end

	local time_per_attack = 1 / self:GetCaster():GetAttacksPerSecond()
	local activities = { ACT_DOTA_ATTACK } --ACT_DOTA_ATTACK2
	local local_attack_point = time_per_attack * self:GetCaster():GetAttackAnimationPoint() * ANIM_END_POINT
	StartAnimation(self:GetCaster(), {
		duration = time_per_attack, 
		activity = activities[RandomInt(1, #activities)], 
		rate = 1 / time_per_attack * 1 / (ANIM_END_POINT),
	})
	target = self:GetCursorTarget()
	local attacking_index = target:GetEntityIndex()
	self:GetCaster().preattack_timer = Timers:CreateTimer(local_attack_point, function()
		if target:GetEntityIndex() ~= attacking_index then
			self:GetCaster().preattack_timer = nil
			self.attack_cooldown_timer = nil
			return
		end
		self:deal_attack(target)
		self:GetCaster().preattack_timer = nil
	end)
end

function ability_universal_attack:deal_attack(target)
	local time_per_attack = 1 / self:GetCaster():GetAttacksPerSecond()

	self.attack_cooldown_timer = Timers:CreateTimer(time_per_attack - time_per_attack * self:GetCaster():GetAttackAnimationPoint() * ANIM_END_POINT, function()
		self.attack_cooldown_timer = nil
	end)

	self:GetCaster():PerformAttack(target, true, true, true, true, true)
	self.attack_timer = nil
end

function ability_universal_attack:GetCastRange( vLocation, hTarget )
	return self:GetCaster():GetAttackRange()
end

function ability_universal_attack:GetCooldown(iLevel) 
	return 0
end