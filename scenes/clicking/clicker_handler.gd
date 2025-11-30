extends Node2D

@onready var open_store = $background/open_store
@onready var background = $background/rect
@onready var background_anim = $background_anim

var arrow = load("res://assets/images/mouse/arrow/mouse_arrow_64x64.png")
var pointing_hand = load("res://assets/images/mouse/pointing_hand/pointing_hand_128x128.png")
var bomb_scene := preload("res://gui/scenes/click_bomb.tscn")
var mini_cursor_scene := preload("res://gui/scenes/mini_cursor.tscn")

var acc = 0.0
var cb = 0.0

var max_click_mult = 5.0

var x: float

var click_burst_loop = 0

var hue: float = 0.0

func _ready() -> void:
	x = 0
	Input.set_custom_mouse_cursor(arrow, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(pointing_hand, Input.CURSOR_POINTING_HAND)

func _process(delta: float) -> void:
	background_anim.play("rgb_background")
	if Items.ghost_click_acquired >= 1:
			acc += delta
			if acc >= Items.ghost_click_cooldown:
				acc = 0
				ghost_click()
				if Items.ghost_click_cooldown > 0:
					AudioPlayer.ghost_click()
	
	if Items.click_mult_acquired >= 1:
			max_click_mult -= delta
			if max_click_mult <= 0.0 and Items.click_mult_active:
				Items.click_mult_active = false
				if Items.click_mult_acquired > 1:
					Items.click_mult_power = 0
				else:
					Items.click_mult_power = 1
				
	
	if !GlobalVars.click_burst_ready and Items.click_burst_acquired > 0:
		cb += delta
		if cb >= GlobalVars.click_burst_cooldown and GlobalVars.click_burst_cooldown != 0:
			cb = 0
			match Items.click_burst_acquired:
				1: click_burst_loop = 3
				2: click_burst_loop = 3
				3: click_burst_loop = 4
				4: click_burst_loop = 4
				5: click_burst_loop = 4
				6: click_burst_loop = 5
				7: click_burst_loop = 10
			GlobalVars.click_burst_ready = true
	
	if GlobalVars.click_burst_cooldown == 0:
		GlobalVars.click_burst_ready = true
		click_burst_loop = 1
	
	if GlobalVars.unlocked_shop:
		open_store.visible = true
	else:
		open_store.visible = false
	
	if x < GlobalVars.mini_cursor_on_screen:
			x += 1
			spawn_cursor()
	
	if Input.is_action_just_pressed("shop") and GlobalVars.unlocked_shop:
		AudioPlayer.open_menu_gui()
		get_tree().change_scene_to_file("res://scenes/store/store.tscn")
	
func _on_button_pressed() -> void:
	
	AudioPlayer.click()
	max_click_mult = 5.0
	Items.click_mult_active = true
	
	
	if GlobalVars.mini_cursor_on_screen < 100:
		GlobalVars.mini_cursor_on_screen += 1
	
	match Items.click_combo_acquired:
		1:
			GlobalVars.click_storage += 1
			if GlobalVars.click_storage == 5:
				GlobalVars.score += GlobalVars.click_power
				GlobalVars.click_storage = 0
		2:
			GlobalVars.click_storage += 1
			if GlobalVars.click_storage == 4:
				GlobalVars.score += GlobalVars.click_power
				GlobalVars.click_storage = 0
		3:
			GlobalVars.click_storage += 1
			if GlobalVars.click_storage == 3:
				GlobalVars.score += GlobalVars.click_power
				GlobalVars.click_storage = 0
		4:
			GlobalVars.click_storage += 1
			if GlobalVars.click_storage == 2:
				GlobalVars.score += GlobalVars.click_power
				GlobalVars.click_storage = 0
		5:
			GlobalVars.click_storage = 0
			GlobalVars.score += GlobalVars.click_power
	
	if GlobalVars.click_burst_ready and Items.click_burst_acquired < 8:
		GlobalVars.click_burst_ready = false
	
	if GlobalVars.click_burst_cooldown > 0:
		while click_burst_loop > 0:
			await get_tree().create_timer(0.2/Items.click_burst_acquired).timeout
			AudioPlayer.click()
			GlobalVars.score += GlobalVars.click_power
			click_burst_loop -= 1
	else:
		while click_burst_loop:
			await get_tree().create_timer(0.1).timeout
			GlobalVars.score += GlobalVars.click_power * Items.click_mult_power
			GlobalVars.avg_score += GlobalVars.click_power * Items.click_mult_power
			var rng = randi_range(0, 100-Items.click_bomb_chance)
			if rng == 0 and Items.click_bomb_acquired > 0:
				spawn_bomb()
			if Items.click_mult_power > Items.click_mult_max and Items.click_mult_acquired == 1:
				Items.click_mult_power = floori(Items.click_mult_power)
			
			if (Items.click_mult_power + Items.click_mult_sum) < Items.click_mult_max and Items.click_mult_acquired > 1:
				Items.click_mult_power += Items.click_mult_sum
				
			if Items.click_mult_power < Items.click_mult_max and Items.click_mult_acquired == 1:
				Items.click_mult_power += Items.click_mult_sum
			
	if Items.click_mult_power > Items.click_mult_max and Items.click_mult_acquired == 1:
		Items.click_mult_power = floori(Items.click_mult_power)
	
	if (Items.click_mult_power + Items.click_mult_sum) < Items.click_mult_max and Items.click_mult_acquired > 1:
		Items.click_mult_power += Items.click_mult_sum
		
	if Items.click_mult_power < Items.click_mult_max and Items.click_mult_acquired == 1:
		Items.click_mult_power += Items.click_mult_sum
	
	var rng = randi_range(0, 100-Items.click_bomb_chance)
	if rng == 0 and Items.click_bomb_acquired > 0:
		spawn_bomb()
	
	if GlobalVars.score >= 10:
		GlobalVars.unlocked_shop = true
	
	GlobalVars.score += GlobalVars.click_power * Items.click_mult_power
	GlobalVars.avg_score += GlobalVars.click_power * Items.click_mult_power

func ghost_click():
	GlobalVars.score += GlobalVars.click_power * Items.click_mult_power
	GlobalVars.avg_score += GlobalVars.click_power * Items.click_mult_power
	match Items.click_combo_acquired:
		
		1:
			GlobalVars.click_storage += 1
			if GlobalVars.click_storage == 5:
				GlobalVars.score += GlobalVars.click_power * Items.click_mult_power
				GlobalVars.click_storage = 0
		2:
			GlobalVars.click_storage += 1
			if GlobalVars.click_storage == 4:
				GlobalVars.score += GlobalVars.click_power * Items.click_mult_power
				GlobalVars.click_storage = 0
		3:
			GlobalVars.click_storage += 1
			if GlobalVars.click_storage == 3:
				GlobalVars.score += GlobalVars.click_power * Items.click_mult_power
				GlobalVars.click_storage = 0
		4:
			GlobalVars.click_storage += 1
			if GlobalVars.click_storage == 2:
				GlobalVars.score += GlobalVars.click_power * Items.click_mult_power
				GlobalVars.click_storage = 0
		5:
			GlobalVars.click_storage = 0
			GlobalVars.score += GlobalVars.click_power * Items.click_mult_power
			
	
	if GlobalVars.click_burst_ready and Items.click_burst_acquired < 8:
		GlobalVars.click_burst_ready = false
	
	if GlobalVars.click_burst_cooldown > 0:
		while click_burst_loop > 0:
			await get_tree().create_timer(0.1).timeout
			GlobalVars.score += GlobalVars.click_power * Items.click_mult_power
			GlobalVars.avg_score += GlobalVars.click_power * Items.click_mult_power
			click_burst_loop -= 1
	else:
		while click_burst_loop:
			await get_tree().create_timer(0.1).timeout
			GlobalVars.score += GlobalVars.click_power * Items.click_mult_power
			GlobalVars.avg_score += GlobalVars.click_power * Items.click_mult_power
			
	var rng = randi_range(0, 100-Items.click_bomb_chance)
	
	if rng == 0 and Items.click_bomb_acquired > 0:
		spawn_bomb()

func _on_open_store_pressed() -> void:
	AudioPlayer.open_menu_gui()
	get_tree().change_scene_to_file("res://scenes/store/store.tscn")

func _on_quit_pressed() -> void:
	AudioPlayer.click()
	await get_tree().create_timer(0.13).timeout
	get_tree().quit()

func spawn_bomb():
	var bomb = bomb_scene.instantiate()
	var gui = $gui
	gui.add_child(bomb)

	# posição inicial opcional
	bomb.position = Vector2(randi_range(100,1800), randi_range(100,980))

func spawn_cursor():
	var cursor = mini_cursor_scene.instantiate()
	var gui = $gui
	gui.add_child(cursor)

	# posição inicial opcional
	cursor.position = Vector2(randi_range(100,1800), randi_range(100,980))
