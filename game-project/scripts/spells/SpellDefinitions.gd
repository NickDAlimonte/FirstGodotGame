# SpellDefinitions.gd
class_name SpellDefinitions

const SPELLS = {
	"Blizzard":{
		"spell_data":{
			"spell_type": "area_persist",
			"spell_id": "1000",
			"spell_damage": 5,
			"spell_duration": 6,
			"tick_rate": 0.5,
			},
		
		"effects":{
			"slow":{
				"power": 100,
				"duration": 8,
				"stackable": 0
			},
			
		}
	},
	
	"Firewall":{
		"spell_data":{
			"spell_type": "area_persist",
			"spell_id": "1001",
			"spell_damage": 15,
			"spell_duration": 12,
			"tick_rate": 1,
			},
		"burn_effect":{
			"type": "debuff",
			"aura_id": "1001",
			"damage": 15,
			"debuff_duration": 4,
			"debuff_tick_rate": 2,
			"stackable": 0
		},
	}
}
