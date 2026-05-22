# SpellDefinitions.gd
class_name SpellDefinitions

const SPELLS = {
	"Blizzard":{
		"spell_data":{
			"spell_id": "1000",
			"spell_damage": 5,
			"spell_duration": 6,
			"tick_rate": 0.5,
			},
		"slow_effect":{
			"type": "debuff",
			"aura_id": "1000",
			 "slow": 100,
			"debuff_duration": 8,
			"stackable": 0
		}
	}
	
	
	
}
