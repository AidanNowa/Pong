extends CharacterBody2D

var win_size : Vector2
const START_SPEED : int = 500
const ACCELERATION : int = 50
var speed : int
var direction : Vector2
const MAX_Y_Vector: float = 0.6

func _ready():
	win_size = get_viewport_rect().size
	
#pick direction and speed for each new ball (reposition with new direction
func new_ball():
	position.x = win_size.x / 2 #x position is always the same
	position.y = randi_range(200, win_size.y - 200)
	speed = START_SPEED
	direction = random_direction()
	
func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		#if ball hits paddle
		$AudioStreamPlayer2D.play()
		if collider == $"../Player" or collider == $"../CPU":
			speed += ACCELERATION
			#standard godot function for bouncing
			direction = new_direction(collider)
		#if it hits a wall
		else:
			direction = direction.bounce(collision.get_normal())
			
func random_direction():
	var new_direction := Vector2()
	new_direction.x = [1, -1].pick_random() #left or right
	new_direction.y = randf_range(1,-1) #more flexibility in y direction
	return new_direction.normalized()
	
#function to change angle from bounce off paddle
#perpendicular when in middle, larger angle when further out
func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir := Vector2()
	
	#flip the horizontal direction
	if direction.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
		
	#handle vertical direction
	#divide distance ball is from center of paddle by the height of the paddle
	#Mutiply by constant to limit what the vector will be
	new_dir.y = (dist / (collider.p_height / 2)) * MAX_Y_Vector
	
	return new_dir.normalized()
