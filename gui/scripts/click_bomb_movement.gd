extends Node2D

@onready var anim = $anim
@onready var animation = $animation

var velocity = Vector2.ZERO
var speed = 150

func _ready():
	# Direção totalmente aleatória
	velocity = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized() * speed
	rotation_degrees = randf_range(0.0,180.0)
	anim.play("bomb")
	if Items.ghost_click_acquired < 6 or Items.click_burst_acquired < 8 or Items.ghost_click_acquired < 6 and Items.click_burst_acquired < 8:
		await get_tree().create_timer(5).timeout
		self_explode()
	else:
		self_explode()

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

func _on_button_pressed() -> void:
	anim.play("explosion")
	AudioPlayer.bomb_explode()
	animation.play("fade_out")
	
func self_explode():
	anim.play("explosion")
	animation.play("fade_out")

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		await get_tree().create_timer(0.1).timeout
		GlobalVars.score += Items.click_bomb_points * (Items.click_mult_power+1)
		get_tree().queue_delete($".")
