extends CharacterBody2D
class_name Entity


const base_speed = 300
@export var speed = base_speed
@export var health = 100
var active_effects = []

func die():
	print("Player died")
	get_tree().quit()
	
@onready var status_effects = $StatusEffectManager

func take_damage(amount, source):
	print(amount, " Damage taken from ", source)
	health -= amount
	if health <= 0:
		die()
	
func add_status_effect(effect):
	status_effects.add_status_effect(effect)
	update_speed()

func remove_status_effect(effect):
	var key = 'effect_' + str(effect["source"])
	status_effects.remove_status_effect(key)
	print(effect,' removed')
	update_speed()
	
func update_speed():
	var speed_mods = status_effects.get_effects()
	var speed_mod = 0
	
	for mods in speed_mods:
		speed_mod += mods
		print(speed_mod)
	
	speed = base_speed + speed_mod
	if speed < 0:
		speed = 0
