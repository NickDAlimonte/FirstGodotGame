extends Node2D

var active_effects = {}

func create_timer(duration, one_shot, autostart):
	var new_timer = Timer.new()
	new_timer.wait_time = duration
	new_timer.one_shot = one_shot
	new_timer.autostart = autostart
	return new_timer

func add_status_effect(effect):
	var key = (str(effect["source"].get_instance_id()) + ":" + str(effect["aura_id"]))
	if effect["stackable"] == 0 && active_effects.has(key):
		return
	
	active_effects[key] = effect
	
	if effect.has("debuff_duration"):
		var debuff_timer = create_timer(effect["debuff_duration"], true, true)
		add_child(debuff_timer)
		
		debuff_timer.timeout.connect(
			remove_status_effect.bind(key)
		)
	get_dots()
	get_parent().set_speed()
		
func remove_status_effect(key):
	active_effects.erase(key)
	get_parent().set_speed()
	
func get_slows():
	var speed_modifiers = []
	
	for effect in active_effects.values():
		if !effect.has("slow") && !effect.has("debuff"):
			continue
		
		speed_modifiers.append(-effect["slow"])
				
	return speed_modifiers
	
func get_dots():
	
	for effect in active_effects.values():
		if !effect.has("damage") && !effect.has("debuff") && !effect.has("debuff_tick_rate"):
			continue
			
		var dot_timer = create_timer(effect['debuff_tick_rate'], false, true)
		add_child(dot_timer)
		
		dot_timer.timeout.connect(func():
			get_parent().take_damage(effect['damage'], self)
			print('damage taken')
			)
