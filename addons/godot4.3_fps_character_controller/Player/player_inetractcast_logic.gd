extends RayCast3D

@export var Prompt : RichTextLabel

func _physics_process(delta: float) -> void:
	Prompt.text = ""
	
	if is_colliding():
		var collider = get_collider()
		
		if collider is Interactable:
			if collider.prompt_action != "":
				Prompt.text = collider.get_prompt() + "\n["+collider.get_key()+"]"
				if Input.is_action_just_pressed(collider.prompt_action):
					collider.interact(owner)
			else:
				Prompt.text = collider.get_prompt()
