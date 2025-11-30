extends VBoxContainer

@onready var buy = $Button
@onready var price = $Label

func _ready() -> void:
	
	match Items.click_combo_acquired:
		1:
			buy.text = "Double Mouse\n+1 each FOUR Clicks"
		2:
			buy.text = "Advanced Touchpad\n+1 each THREE clicks"
		3:
			buy.text = "Quantum-Computer\n+1 each TWO clicks"
		4:
			buy.text = "Universal Clicker\n+1 EACH click!\n[DOUBLE your clicks!]"
		5:
			queue_free()
	
	price.text =  Formatter.format_number(Items.click_combo_price) + " Points"

func _physics_process(_delta: float) -> void:
	if GlobalVars.score < Items.click_combo_price:
		buy.disabled = true
	else:
		buy.disabled = false

func _on_button_pressed() -> void:
	if GlobalVars.score >= Items.click_combo_price:
		AudioPlayer.bought_item()
		GlobalVars.score -= Items.click_combo_price
		Items.click_combo_acquired += 1
		Items.click_combo_price = 750 * roundf(pow(10, Items.click_combo_acquired))
		
	match Items.click_combo_acquired:
		1:
			buy.text = "Double Mouse\n+1 each FOUR Clicks"
		2:
			buy.text = "Advanced Touchpad\n+1 each THREE clicks"
		3:
			buy.text = "Quantum-Computer\n+1 each TWO clicks"
		4:
			buy.text = "Universal Clicker\n+1 EACH click!\n[DOUBLE your clicks!]"
		5:
			queue_free()
	price.text =  Formatter.format_number(Items.click_combo_price) + " Points"
