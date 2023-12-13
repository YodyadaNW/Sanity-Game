extends CharacterBody2D


var wait_time = 0.0
var end_time = 0.1
var hp = 1
var destroy_time = 0.7

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	set_process(true)
	pass

func _physics_process(delta):
	translate(Vector2(-0.3,0))
	var collision = move_and_collide(Vector2(0,15))
	if collision:
		if collision.get_collider().name == "bullet(Clone)":
			print("Hit")
			hp = hp-1
		
	if hp <= 0:
		wait_time += delta
		if wait_time > end_time:
			translate(Vector2(0,0))
			get_node("AnimatedSprite2D").play("dead")
			if wait_time >= destroy_time:
				destroy()
				
func destroy():
	queue_free()
