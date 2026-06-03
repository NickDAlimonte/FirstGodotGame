extends Node2D
class_name SpellController

static func determine_spell_type(spell_cast, spell_source):
	var spell = spell_cast.duplicate(true)
	var source = spell_source
	print(spell["spell_data"]["spell_type"])
	if spell.has("spell_data") && spell["spell_data"].has("spell_type") && spell["spell_data"]["spell_type"] == "area_persist":
		var spell_scene = preload("res://scripts/spells/AreaPersistEffect.tscn")
		var create_spell = spell_scene.instantiate()
		
		create_spell.initialize(spell, source)
