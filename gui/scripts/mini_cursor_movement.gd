extends Node2D

@onready var anim = $anim
@onready var animation = $animation

var velocity = Vector2.ZERO
var speed = 150

func _ready():
	# Direção totalmente aleatória
	animation.play("fade_in")
	velocity = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized() * speed
	anim.play("arrow")

func _process(delta):
	position += velocity * delta
	rotation_degrees += 0.25
	check_bounce()

func check_bounce():
	var screen_size = get_viewport_rect().size

	# Bate nas bordas X
	if position.x < 0:
		position.x = 0
		velocity.x *= -1
	elif position.x > screen_size.x:
		position.x = screen_size.x
		velocity.x *= -1

	# Bate nas bordas Y
	if position.y < 0:
		position.y = 0
		velocity.y *= -1
	elif position.y > screen_size.y:
		position.y = screen_size.y
		velocity.y *= -1
