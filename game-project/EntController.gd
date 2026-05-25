extends CharacterBody2D
class_name Entity


const base_speed: int = 300
var selected_spell = null
@export var speed = base_speed
@export var max_health: int = 100
@export var health: int = 100
@onready var status_effects = $StatusEffectManager

var active_effects = []

func _process(delta: float):
	if health > max_health:
		health = max_health
		
	if speed < 0:
		speed = 0
		
	if health <= 0:
		die()
	

func die():
	print("Player died")
	get_tree().quit()
	

func take_damage(amount, source):
	health -= amount
	
func add_status_effect(effect):
	status_effects.add_status_effect(effect)

func remove_status_effect(effect):
	var key = (str(effect["source"].get_instance_id()) + ":" + str(effect["aura_id"]))
	status_effects.remove_status_effect(key)
	
func set_speed():
	var speed_mods = status_effects.get_slows()
	var speed_mod = 0
	for mods in speed_mods:
		speed_mod += mods
	speed = base_speed + speed_mod

func cast_spell(selected, spell_position = Vector2(0,0)):
	var spell_scene = preload("res://scripts/spells/AreaPersistEffect.tscn")
	var spell = spell_scene.instantiate()
	if selected == 1:
		spell.initialize(SpellDefinitions.SPELLS["Firewall"], self)
	elif selected == 0:
		spell.initialize(SpellDefinitions.SPELLS["Blizzard"], self)
	get_parent().add_child(spell)
	spell.global_position = spell_position
