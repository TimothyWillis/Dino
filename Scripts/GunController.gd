extends Spatial

#var shotgun_scene = preload("res://Player/Weapons/Shotgun.tscn")

var current_weapon = 0
var shotgun

onready var gunslot_0 = $GunSlot0
onready var gunslot_1 = $GunSlot1

#export var raycast_path = "Head/Camera/WeaponRayCast"
#export var camera_path = "Head/Camera"


func _ready():
	print("Loaded guncontroller")
	
	#shotgun = shotgun_scene.instance()
	
	
	
	# Hide 2nd weapon if starting with 2
	if gunslot_1.get_child(0):
		gunslot_1.get_child(0).set_process(false)
		gunslot_1.hide()
	pass


func _process(delta):
	
	if Input.is_action_just_pressed("swap_weapon"):
		cycle_weapon()

# Determine the weapon to be picked up
func parse_weapon_pickup(weapon):
	if weapon.gun_name == "Shotgun":
		#return shotgun
		pass

# Determine action after weapon is picked up
func pickup_weapon(weapon_obj):
	print("Picked up %s" % weapon_obj.gun_name)
	var weapon = weapon_obj.weapon #parse_weapon_pickup(weapon_obj)
	
	if !gunslot_0.get_child(0):
		add_weapon(weapon, gunslot_0)
		cycle_weapon()
	elif !gunslot_1.get_child(0):
		add_weapon(weapon, gunslot_1)
		cycle_weapon()
	else:
		swap_weapon(weapon)
		

# Swap your current weapon with a pickup
func swap_weapon(weapon):
	if current_weapon == 0:
		drop_weapon(gunslot_0)
		add_weapon(weapon, gunslot_0)
	elif current_weapon == 1:
		drop_weapon(gunslot_1)
		add_weapon(weapon, gunslot_1)

func add_weapon(weapon, gunslot):
	gunslot.add_child(weapon)

# Cycle through weapons you already have
func cycle_weapon():
	if current_weapon == 0 and gunslot_1.get_child(0):
		gunslot_0.get_child(0).set_process(false)
		gunslot_0.hide()
		
		gunslot_1.get_child(0).set_process(true)
		gunslot_1.show()
		
		current_weapon = 1
	elif current_weapon == 1 and gunslot_0.get_child(0):
		gunslot_1.get_child(0).set_process(false)
		gunslot_1.hide()
		
		gunslot_0.get_child(0).set_process(true)
		gunslot_0.show()
		
		current_weapon = 0
	print(current_weapon)

# Removes current weapon from player and spawns new weapon pickup item with stats of gun
func drop_weapon(gunslot):
	gunslot.get_child(0).queue_free()

func already_have_weapon(weapon):
	return false
