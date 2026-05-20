extends Area2D

@export var spell_damage = 10
@export var speed_mod = 100

var bodies_inside = []

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	$TickTime.timeout.connect(_on_timer_timeout)
	$DurationTimer.timeout.connect(_on_duration_timeout)
	

func _on_body_entered(body):
	var slow_effect = {
	"source": self,
	"type": "slow",
	"duration": 8,
	"speed": speed_mod
}
	$TickTime.start()
	bodies_inside.append(body)
	if body.has_method("take_damage"):
		body.take_damage(spell_damage, self)
	if body.has_method("add_status_effect"):
		body.add_status_effect(slow_effect)
	
func _on_body_exited(body):
	bodies_inside.erase(body)

	
func _on_timer_timeout():

	
	for body in bodies_inside:
		
		if body.has_method("take_damage"):
			body.take_damage(spell_damage, self)
			
func _on_duration_timeout():
	queue_free()
