extends WeaponPickup

func _ready():
	weapon_scene = preload("res://Player/Weapons/AssaultRifle.tscn")
	weapon = weapon_scene.instance()
	gun_name = "AssaultRifle"
