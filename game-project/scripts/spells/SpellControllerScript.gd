extends Node2D
class_name SpellController
var spell
var source

func select_spell_type(spell_cast, spell_source):
	spell = spell_cast.duplicate(true)
	source = spell_source
	
	if spell_cast.has("spell_type") && spell_cast["spell_type"] == "area":
		pass
		
	else:
		print("test")
