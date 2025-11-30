extends VBoxContainer

@onready var buy = $Button
@onready var price = $Label

func _ready() -> void:
	price.text =  Formatter.format_number(Items.passive_miner_price) + " Points"
	buy.text = "Passive Miner\n+" + Formatter.format_number(Items.passive_miner_power) + " Point/s"

func _physics_process(_delta: float) -> void:
	if GlobalVars.score < Items.passive_miner_price:
		buy.disabled = true
	else:
		buy.disabled = false

func _on_button_pressed() -> void:
	if GlobalVars.score >= Items.passive_miner_price:
		AudioPlayer.bought_item()
		GlobalVars.score -= Items.passive_miner_price
		GlobalVars.click_power += 1
		Items.passive_miner_acquired += 1
		Items.passive_miner_price = 125 * roundf(pow(1.8, Items.passive_miner_acquired))
	price.text =  Formatter.format_number(Items.passive_miner_price) + " Points"
	buy.text = "Passive Miner\n+" + Formatter.format_number(Items.passive_miner_power) + " Point/s"
