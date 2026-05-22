extends Area2D

var bodies_inside = []
var spell_data = {}
var effect = {}
var spell_damage


func initialize(spell, source):
	spell_data = spell.duplicate(true)
	spell_data["source"] = source
	##Effects must be read as a dictionary, otherwise it will crash in the manager
	effect = spell_data["Effect"]
	effect["source"] = source

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	$TickTime.wait_time = spell_data["tick_rate"]
	$TickTime.timeout.connect(_on_timer_timeout)
	$DurationTimer.wait_time = spell_data["spell_duration"]
	$DurationTimer.timeout.connect(_on_duration_timeout)
	$DurationTimer.start()
	
	spell_damage = spell_data["spell_damage"]

func _on_body_entered(body):

	$TickTime.start()
	bodies_inside.append(body)
	if body.has_method("take_damage") && spell_damage > 0:
		body.take_damage(spell_damage, self)
	if body.has_method("add_status_effect"):
		body.add_status_effect(effect)
	
func _on_body_exited(body):
	bodies_inside.erase(body)
	if body.has_method("remove_status_effect"):
		body.remove_status_effect(effect)

	
func _on_timer_timeout():
	
	for body in bodies_inside:
		if body.has_method("take_damage"):
			body.take_damage(spell_damage, self)
			
func _on_duration_timeout():
	queue_free()
