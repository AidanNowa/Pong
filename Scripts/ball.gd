extends CharacterBody2D

var win_size : Vector2
const START_SPEED : int = 500
const ACCELERATION : int = 50
var speed : int
var direction : Vector2

func _ready():
	win_size = get_viewport_rect().size
	
#pick direction and speed for each new ball (reposition with new direction
func new_ball():
	position.x = win_size.x / 2 #x position is always the same
	position.y = randi_range(200, win_size.y - 200)
	speed = START_SPEED
	direction = random_direction()
	
func _physics_process(delta):
	move_and_collide(direction * speed * delta)
	
func random_direction():
	var new_direction := Vector2()
	new_direction.x = [1, -1].pick_random() #left or right
	new_direction.y = randf_range(1,-1) #more flexibility in y direction
	return new_direction.normalized()
