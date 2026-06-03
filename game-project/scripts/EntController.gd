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
	print(amount, " damage taken from ", source)
	if health <= 0:
		die()
	
func apply_status_effect(effect: Dictionary, source = null):
	status_effects.determine_type(effect, source)

func remove_status_effect(effect):
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
#ent_name is defined on ready, and must be passed to the spell, to track who cast each spell, and applied effects
func cast_spell(selected, spell_position = Vector2(0,0)):
	SpellController.determine_spell_type(SpellDefinitions.SPELLS['Blizzard'], ent_name)
