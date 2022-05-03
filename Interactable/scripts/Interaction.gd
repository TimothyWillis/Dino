extends RayCast

onready var interaction_label = get_node("/root/World/UI/InteractionLabel")
onready var gun_controller = $"../GunController"

var current_collider

func _ready():
	set_interaction_text("")

func _process(delta):
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			set_interaction_text(collider.get_interaction_text())
			current_collider = collider
		
		if Input.is_action_just_pressed("interact"):
			collider.interact()
			set_interaction_text(collider.get_interaction_text())
			if collider is WeaponPickup:
				gun_controller.pickup_weapon(collider)
	elif current_collider:
		current_collider = null
		set_interaction_text("")

func set_interaction_text(text):
	if !text:
		interaction_label.set_text("")
		interaction_label.set_visible(false)
	else:
		var interact_key = OS.get_scancode_string(InputMap.get_action_list("interact")[0].physical_scancode)
		interaction_label.set_text("Press %s to %s" % [interact_key, text])
		interaction_label.set_visible(true)

