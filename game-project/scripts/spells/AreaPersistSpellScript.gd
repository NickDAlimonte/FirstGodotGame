extends Area2D

var bodies_inside = []
var spell = {}
var spell_data = {}
var effects = {}
var spell_damage
var initialized := false
var caster

func initialize(spell_used, source):
	caster = source
	##Effects must be read as a dictionary, otherwise it will crash in the manager

	spell = spell_used.duplicate(true)
	if spell.has("spell_data"):
		spell_data = spell["spell_data"]
		spell.erase("spell_data")
	
	for effect_items in spell:
		spell[effect_items]["source"] = source
		print("The source is: ", source)
		
	print(source)

func _ready() -> void:
	assert(initialize, "Spell was instantiated without initialize()")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	if spell_data.has("tick_rate"):
		$TickTime.wait_time = spell_data["tick_rate"]
		$TickTime.timeout.connect(_on_timer_timeout)
	
	if spell_data.has("spell_duration"):
		$DurationTimer.wait_time = spell_data["spell_duration"]
		$DurationTimer.timeout.connect(_on_duration_timeout)
		$DurationTimer.start()
	
	spell_damage = spell_data["spell_damage"]

func _on_body_entered(body):

	$TickTime.start()
	bodies_inside.append(body)
	if body.has_method("take_damage") && spell_damage > 0:
		body.take_damage(spell_damage, caster)
	if body.has_method("add_status_effect"):
		for effect in spell:
			body.add_status_effect(spell[effect])
	
func _on_body_exited(body):
	bodies_inside.erase(body)
	if body.has_method("remove_status_effect"):
		for effect in spell:
			if !spell[effect].has('debuff_duration'):
				body.remove_status_effect(spell[effect])

func _on_timer_timeout():
	
	for body in bodies_inside:
		if body.has_method("take_damage"):
			body.take_damage(spell_damage, caster)
			
func _on_duration_timeout():
	queue_free()
