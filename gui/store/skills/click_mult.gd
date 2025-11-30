extends VBoxContainer

@onready var buy = $Button
@onready var price = $Label
@onready var vbox = $"."

func _ready() -> void:
	if Items.click_mult_acquired == 0:
		buy.text = "Click Mult\n+" + Formatter.format_number(Items.click_mult_sum * pow(2,2)) + " Points each Click!\n[Up to +"+ Formatter.format_number(Items.click_mult_max * pow(2,2)) + "]"
		buy.tooltip_text = "Each PLAYER CLICK [Ghost Clicks doesn't apply] adds:\n+0 [Up to +0!]"
	if Items.click_mult_acquired <= 6 and Items.click_mult_acquired != 0:
			buy.text = "Click Mult\n+" + Formatter.format_number(Items.click_mult_sum * pow(2,2)) + " Points each Click!\n[Up to +"+ Formatter.format_number(Items.click_mult_max * pow(2,2)) + "]"
			buy.tooltip_text = "Each PLAYER CLICK [Ghost Clicks doesn't apply] adds:\n+" + Formatter.format_number(Items.click_mult_sum) + " [Up to +"+ Formatter.format_number(Items.click_mult_max) +"]\nto the multiplier, increasing your gains exponentially!\n** APPLY TO PASSIVE MINER! **"
	price.text =  Formatter.format_number(Items.click_mult_price) + " Points"

func _physics_process(_delta: float) -> void:
	if GlobalVars.score < Items.click_mult_price and Items.click_mult_acquired < 5:
		buy.disabled = true
	else:
		buy.disabled = false
	
	if Items.click_mult_acquired == 5:
		buy.disabled = true
		buy.text = "Click Mult\nSold Out!"

func _on_button_pressed() -> void:
	if GlobalVars.score >= Items.click_mult_price:
		AudioPlayer.bought_item()
		GlobalVars.score -= Items.click_mult_price
		Items.click_mult_acquired += 1
		Items.click_mult_sum *= pow(2,2)
		Items.click_mult_max *= pow(2,2)
		Items.click_mult_price = 2550 * roundf(pow(3.1, Items.click_mult_acquired))
	
	if Items.click_mult_acquired > 1:
		Items.click_mult_power = 0.0
	
	if Items.click_mult_acquired < 6:
			buy.text = "Click Mult\n+" + Formatter.format_number(Items.click_mult_sum * pow(2,2)) + " Points each Click!\n[Up to +"+ Formatter.format_number(Items.click_mult_max * pow(2,2)) + "]"
			buy.tooltip_text = "Each PLAYER CLICK [Ghost Clicks doesn't apply] adds:\n+" + Formatter.format_number(Items.click_mult_sum) + " [Up to +"+ Formatter.format_number(Items.click_mult_max) +"]\nto the multiplier, increasing your gains exponentially!\n** APPLY TO PASSIVE MINER! **"
	price.text =  Formatter.format_number(Items.click_mult_price) + " Points"
