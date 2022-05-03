extends Interactable

class_name WeaponPickup

export var weapon_scene = preload("res://Player/Weapons/Gun.tscn")
var weapon = weapon_scene.instance()
var gun_name = "Gun"


export var gravity = 0.98

func get_interaction_text():
	return "Take %s" % gun_name

func interact():
	# Delete Self
	get_parent().get_parent().queue_free()
