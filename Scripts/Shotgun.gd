extends Weapon

export var fire_range = 10

func _ready():
	raycast.cast_to = Vector3(0,0, -fire_range)
	weapon_name = "Shotgun"
	audio_delay = 0
	#gun_body.set_mesh("res://Assets/3D/Guns/ShotGun.obj")
	
