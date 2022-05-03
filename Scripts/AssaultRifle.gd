extends Weapon

export var fire_range = 75

func _ready():
	raycast.cast_to = Vector3(0,0, -fire_range)
	weapon_name = "Assault Rifle"
	full_auto = true
	#gun_body.set_mesh("res://Assets/3D/Guns/ShotGun.obj")
	
