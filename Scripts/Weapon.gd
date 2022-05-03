extends Spatial

class_name Weapon

export var fire_rate = 0.5
export var clip_size = 5
export var reload_speed = 1.0
export var default_position : Vector3
export var ads_position : Vector3 = Vector3(-0.827,0.29,-0.618)
export var ads_acceleration : float = 0.3
export var default_fov : float = 70
export var ads_fov : float = 55

export var recoil_offset : Vector3
export var recoil_acceleration : float = 0.8

#export var gun_body_path : NodePath
#onready var gun_body = $"../Head/Camera/GunBody"
onready var ammo_ui = $"/root/World/UI/Ammo"
onready var name_ui = $"/root/World/UI/GunName"
onready var gun_controller = $"/root/World/Player/Head/Camera/GunController"
onready var gun_audio = $"/root/World/Player/Head/Camera/GunController/GunAudio"

onready var raycast_path = "/root/World/Player/Head/Camera/WeaponRayCast"
onready var camera_path = "/root/World/Player/Head/Camera"

onready var bullet_decal = preload("res://Player/Weapons/BulletDecal.tscn")

var audio_delay = 0.05
var full_auto = false
var current_ammo = clip_size
var can_fire = true
var reloading = false
onready var raycast : RayCast = get_node(raycast_path)
var camera : Camera

var weapon_name = "debugGUN"

func _ready():
	current_ammo = clip_size
	#raycast = get_node(raycast_path)
	camera = get_node(camera_path)
	

func _process(delta):
	if not reloading:
		ammo_ui.set_text("%d / %d" % [current_ammo, clip_size])
	name_ui.set_text(weapon_name)
	
	if full_auto:
		if Input.is_action_pressed("primary_fire") and can_fire:
			fire()
	else:
		if Input.is_action_just_pressed("primary_fire") and can_fire:
			fire()
	
	if Input.is_action_just_pressed("reload"):
		reload()
	
	if Input.is_action_pressed("ads"):
		transform.origin = transform.origin.linear_interpolate(ads_position, ads_acceleration)
		camera.fov = lerp(camera.fov, ads_fov, ads_acceleration)
	else:
		transform.origin = transform.origin.linear_interpolate(default_position, ads_acceleration)
		camera.fov = lerp(camera.fov, default_fov, ads_acceleration)

func fire():
	if current_ammo > 0 and not reloading:
		print("BANG!!")
		current_ammo -= 1
		gun_audio.play(audio_delay)
		check_collision()
		can_fire = false
		
		yield(get_tree().create_timer(fire_rate),"timeout")
		can_fire = true
	else:
		# TODO add end of clip sound
		reload()

func reload():
	if not reloading and current_ammo != clip_size:
		print("Reloading...")
		ammo_ui.set_text("Reloading...")
		reloading = true
		reload_animation()#BROKEN
		yield(get_tree().create_timer(reload_speed),"timeout")
		current_ammo = clip_size
		reloading = false
		print("Done Reload")
	else:
		print("Won't have any effect...")


func reload_animation():
	# TODO Play reload animation and play reload sound
	pass

func check_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		display_bullet_hole(collider)
		if collider.is_in_group("Enemies"):
			enemy_hit(collider)
			print(collider.name + " killed")
	
func enemy_hit(enemy):
	enemy.queue_free()
	#probably some signal shit idk

func display_bullet_hole(collider):
	var bh = bullet_decal.instance()
	collider.add_child(bh)
	bh.global_transform.origin = raycast.get_collision_point()
	bh.look_at(raycast.get_collision_point() + raycast.get_collision_normal(), Vector3.UP)
