local abilities = LoadKeyValues("scripts/npc/npc_abilities_custom.txt")
local modifiers = {}

_G.UniversalShields = {}

for ability_name, kv in pairs(abilities) do
	if kv.Modifiers ~= nil then
		for modifier_name, modifier_kv in pairs(kv.Modifiers) do
			if modifier_kv.IsUniversalShield then
				_G.UniversalShields[#_G.UniversalShields + 1] = modifier_name
			end
		end
	end
end