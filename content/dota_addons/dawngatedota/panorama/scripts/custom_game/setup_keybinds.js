function WrapFunction(name)
{
	return function() {/*$.Msg("WarpFunction " + name + ": ", Game[name]); */ Game[name](); };
}

Game.AddCommand( "+SpiritgateSpell1", WrapFunction("SpiritgateSpell1"), "", 0 );
Game.AddCommand( "+SpiritgateSpell2", WrapFunction("SpiritgateSpell2"), "", 0 );
Game.AddCommand( "+SpiritgateSpell3", WrapFunction("SpiritgateSpell3"), "", 0 );
Game.AddCommand( "+SpiritgateUltimate", WrapFunction("SpiritgateUltimate"), "", 0 );
Game.AddCommand( "+SpiritgateConsumable", WrapFunction("SpiritgateConsumable"), "", 0 );
Game.AddCommand( "+SpiritgateRecall", WrapFunction("SpiritgateRecall"), "", 0 );
Game.AddCommand( "+SpiritgateShop", WrapFunction("SpiritgateShop"), "", 0 );
Game.AddCommand( "+SpiritgateCenterCamera", WrapFunction("SpiritgateCenterCamera"), "", 0 );
Game.AddCommand( "-SpiritgateCenterCamera", WrapFunction("SpiritgateCenterCamera"), "", 0 );
Game.AddCommand( "+SpiritgateAbilityQ", WrapFunction("SpiritgateAbilityQ"), "", 0 );
Game.AddCommand( "+SpiritgateAbilityW", WrapFunction("SpiritgateAbilityW"), "", 0 );
Game.AddCommand( "+SpiritgateAbilityE", WrapFunction("SpiritgateAbilityE"), "", 0 );
Game.AddCommand( "+SpiritgateAbilityR", WrapFunction("SpiritgateAbilityR"), "", 0 );
Game.AddCommand( "+SpiritgateAbilityWard", WrapFunction("SpiritgateAbilityWard"), "", 0 );