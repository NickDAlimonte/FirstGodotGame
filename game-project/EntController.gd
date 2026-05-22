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
		
	if health == 0:
		die()

func die():
	print("Player died")
	get_tree().quit()
	

func take_damage(amount, source):
	print(amount, " Damage taken from ", source)
	health -= amount
	
func add_status_effect(effect):
	status_effects.add_status_effect(effect)
	update_stats()

func remove_status_effect(effect):
	var key = 'effect_' + str(effect["source"])
	status_effects.remove_status_effect(key)
	print(effect,' removed')
	update_stats()
	
func update_stats():
	var speed_mods = status_effects.get_effects()
	var dot_damage = status_effects.get_effects()
	var hot_healing = status_effects.get_effects()
	
	var damage_taken = 0
	var healing_taken = 0
	var speed_mod = 0
	
	for mods in speed_mods:
		speed_mod += mods
		print(speed_mod)
	
	speed = base_speed + speed_mod
	if speed < 0:
		speed = 0

func cast_spell(selected):
	if selected == null:
		var spell_scene = preload("res://scripts/spells/AreaPersistEffect.tscn")
		
		var spell = spell_scene.instantiate()
		spell.initialize(SpellDefinitions.SPELLS["Blizzard"], self)
		
		add_child(spell)
