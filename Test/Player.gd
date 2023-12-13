extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


#Attack
var isAttackPressed = false
var fire_rate = 0.0
var next_fire = 0.2
# เรียกใช้ bullet.tscn
const bulletPath = preload("res://bullet.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction > 0:
		global.global_direction = 1
	elif direction < 0:
		global.global_direction = -1
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#ทำให้วิ่งได้
	if velocity.x < 0:
		get_node("AnimatedSprite2D").play("run")
		#ให้วิ่งไปทางซ้ายเป็นจริง
		get_node("AnimatedSprite2D").set_flip_h(true)
	elif velocity.x > 0:
		get_node("AnimatedSprite2D").play("run")
		#ให้วิ่งไปทางซ้ายเป็นเท็จ ก็คือให้ไปทางขวา
		get_node("AnimatedSprite2D").set_flip_h(false)
	else:
		get_node("AnimatedSprite2D").play("idle")
		
	move_and_slide()
	
	
#Fire Attack
	# ถ้ากดปุ่ม P จะโจมตี
	if Input.is_key_pressed(KEY_P):
		if isAttackPressed==false:
			fire()
			isAttackPressed=true

	fire_rate += delta
	if fire_rate >= next_fire:
		fire_rate = 0
		isAttackPressed=false
	pass


func fire():
	var bullet = bulletPath.instantiate()
	bullet.set_name("bullet(Clone)")
	get_node(".").add_child(bullet)
	pass
