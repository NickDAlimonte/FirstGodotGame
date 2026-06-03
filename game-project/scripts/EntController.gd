extends CharacterBody2D
class_name Entity


const base_speed: int = 300
var selected_spell = null
@export var speed = base_speed
@export var max_health: int = 400
@export var health: int = 400
@onready var status_effects = $StatusEffectManager
@onready var ent_name = "Entity"


func _process(delta: float):
	if health > max_health:
		health = max_health
		
	if health <= 0:
		die()
	
func die():
	print(ent_name, " died")
	queue_free()
	
func take_damage(amount, source):
	health -= amount
	print(amount, " damage taken from ", source.ent_name)
	if health <= 0:
		die()
	
func apply_status_effect(effect: Dictionary, source = null):
	status_effects.determine_effect(effect, source)

func remove_status_effect(effect, source):
	pass
#	var key = (str(effect["source"]) + ":" + str(effect["aura_id"]))
#	status_effects.remove_status_effect(key)

func set_speed():
	var speed_mods = status_effects.get_slows()
	var speed_mod = 0
	for mods in speed_mods:
		speed_mod += mods
	speed = base_speed + speed_mod
	if speed < 0:
		speed = 0
#cast_spell sends spell and entity data to a helper function in the spellcontroller which will determine how to handle that information
#create spell gets passed the information from cast_spell and instantiates the ability.
func cast_spell(selected, spell_position = Vector2(0,0)):
	if selected == 0:
		SpellController.determine_spell_type(SpellDefinitions.SPELLS['Blizzard'], self)
	if selected == 1:
		SpellController.determine_spell_type(SpellDefinitions.SPELLS['Firewall'], self)

func create_spell(spell):
	get_parent().add_child(spell)
