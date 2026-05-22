# SpellDefinitions.gd
class_name SpellDefinitions

const SPELLS = {
	"Blizzard":{
		"spell_id": "1000",
		"spell_damage": 5,
		"spell_duration": 4,
		"tick_rate": 0.5,
		
		"Effect":{
			"type": "debuff",
			"aura_id": "1000",
			 "slow": 100,
			"debuff_duration": 8,
			"stackable": 0
		}
	}
	
	
	
}
