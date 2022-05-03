extends WeaponPickup

func _ready():
	weapon_scene = preload("res://Player/Weapons/Shotgun.tscn")
	weapon = weapon_scene.instance()
	gun_name = "Shotgun"
