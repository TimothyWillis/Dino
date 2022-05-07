extends WeaponPickup

func _ready():
	weapon_scene = preload("res://Player/Weapons/Smg.tscn")
	weapon = weapon_scene.instance()
	gun_name = "SMG"
