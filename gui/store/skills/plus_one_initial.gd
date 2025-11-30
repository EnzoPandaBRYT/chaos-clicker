extends VBoxContainer

@onready var buy = $Button
@onready var price = $Label

func _ready() -> void:
	price.text =  Formatter.format_number(Items.plus_one_initial_price) + " Points"
	

func _physics_process(_delta: float) -> void:
	if GlobalVars.score < Items.plus_one_initial_price:
		buy.disabled = true
	else:
		buy.disabled = false

func _on_button_pressed() -> void:
	if GlobalVars.score >= Items.plus_one_initial_price:
		AudioPlayer.bought_item()
		GlobalVars.score -= Items.plus_one_initial_price
		GlobalVars.click_power += 1
		Items.plus_one_initial_acquired += 1
		Items.plus_one_initial_price = 10 * round(pow(1.5, Items.plus_one_initial_acquired))
	price.text =  Formatter.format_number(Items.plus_one_initial_price) + " Points"
