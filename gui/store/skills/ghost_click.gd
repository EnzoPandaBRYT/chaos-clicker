extends VBoxContainer

@onready var buy = $Button
@onready var price = $Label
@onready var vbox = $"."

func _ready() -> void:
	price.text =  Formatter.format_number(Items.ghost_click_price) + " Points"
	
	match Items.ghost_click_acquired:
		1:
			buy.text = "Intelligent Spirits\n+1 Click/4 sec\n[Counts as Player Clicks]"
		2:
			buy.text = "Poltergeist Clicks\n+1 Click/3 sec\n[Counts as Player Clicks]"
		3:
			buy.text = "Shadow Clicks\n+1 Click/2 sec\n[Counts as Player Clicks]"
		4:
			buy.text = "Entitys Clicks\n+1 Click/1 sec\n[Counts as Player Clicks]"
		5:
			buy.text = "Perfect Clone\n+1 Click/No Cooldown\n[Counts as Player Clicks]"
	price.text =  Formatter.format_number(Items.ghost_click_price) + " Points"

func _physics_process(_delta: float) -> void:
	if GlobalVars.score < Items.ghost_click_price:
		buy.disabled = true
	else:
		buy.disabled = false
		
	if Items.ghost_click_acquired >= 6:
		buy.disabled = true
		queue_free()

func _on_button_pressed() -> void:
	if GlobalVars.score >= Items.ghost_click_price:
		AudioPlayer.bought_item()
		GlobalVars.score -= Items.ghost_click_price
		Items.ghost_click_acquired += 1
		Items.ghost_click_cooldown -= 1.0
		Items.ghost_click_price = 450 * roundf(pow(9, Items.ghost_click_acquired))
	
	match Items.ghost_click_acquired:
		1:
			buy.text = "Intelligent Spirits\n+1 Click/4 sec\n[Counts as Player Clicks]"
		2:
			buy.text = "Poltergeist Clicks\n+1 Click/3 sec\n[Counts as Player Clicks]"
		3:
			buy.text = "Shadow Clicks\n+1 Click/2 sec\n[Counts as Player Clicks]"
		4:
			buy.text = "Entitys Clicks\n+1 Click/1 sec\n[Counts as Player Clicks]"
		5:
			buy.text = "Perfect Clone\n+1 Click/No Cooldown\n[Counts as Player Clicks]"
	price.text =  Formatter.format_number(Items.ghost_click_price) + " Points"
