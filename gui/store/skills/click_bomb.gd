extends VBoxContainer

@onready var buy = $Button
@onready var price = $Label

func _ready() -> void:
	
	if Items.click_bomb_acquired < 50:
		buy.text = "Click Bomb\n" + str(Items.click_bomb_chance+1) + "% of chance to spawn\na bomb with " + Formatter.format_number(Items.click_bomb_points) + " Clicks"
	
	price.text =  Formatter.format_number(Items.click_bomb_price) + " Points"

func _physics_process(_delta: float) -> void:
	if GlobalVars.score < Items.click_bomb_price or Items.click_bomb_acquired >= 50:
		buy.disabled = true
	if GlobalVars.score >= Items.click_bomb_price and Items.click_bomb_acquired < 50:
		buy.disabled = false
	elif Items.click_bomb_acquired >= 50:
		buy.text = "Click Bomb\nSOLD OUT"

	buy.tooltip_text = "Adds a chance of spawning a powerful\ngolden bomb that contains " + Formatter.format_number(Items.click_bomb_points) + " Clicks.\nActual chance: " + str(Items.click_bomb_chance) + "%\nWith your Max Mult: " + Formatter.format_number(Items.click_bomb_points * Items.click_mult_max)
func _on_button_pressed() -> void:
	if GlobalVars.score >= Items.click_bomb_price:
		AudioPlayer.bought_item()
		GlobalVars.score -= Items.click_bomb_price
		Items.click_bomb_acquired += 1
		Items.click_bomb_chance += 1
		Items.click_bomb_points += 100000 * roundf(pow(1.05, Items.click_bomb_acquired))
		Items.click_bomb_price = 15000 * roundf(pow(1.5, Items.click_bomb_acquired))
	
	if Items.click_bomb_acquired < 50:
		buy.text = "Click Bomb\n" + str(Items.click_bomb_chance+1) + "% of chance to spawn\na bomb with " + Formatter.format_number(Items.click_bomb_points) + " Clicks"
	price.text =  Formatter.format_number(Items.click_bomb_price) + " Points"
