extends Area2D


export var speed = 7 # How fast the player will move (pixels/sec).
export var slow_factor = .8 #slows by 1%
var screen_size  # Size of the game window.
var velocity = Vector2()  # The player's movement vector.


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	do_movement(delta)




func do_movement(delta: float):
	#adds slowing force
	velocity.x = (velocity.x * pow(slow_factor, delta))
	velocity.y = (velocity.y * pow(slow_factor, delta))
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	if Input.is_action_pressed("ui_down"):
		velocity.y += speed
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed
	if velocity.length() > 0:
		#velocity = velocity.normalized() * speed	#mult by global speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	print(velocity.x)
		
	#actually change pos
	position += velocity * delta#delta is time btwn frames, mult so fps does not fuck things up
	position.x = clamp(position.x, 0, screen_size.x)  #clamp makes sure it says in game window
	position.y = clamp(position.y, 0, screen_size.y)


func _on_Player_body_entered(body):
	velocity.bounce()
