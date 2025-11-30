extends VBoxContainer

@onready var buy = $Button
@onready var price = $Label

func _ready() -> void:
	
	match Items.click_burst_acquired:
		1: buy.text = "Pressure Watergun\nA burst of 3 clicks each 4 seconds\n[On Player Click]"
		2: buy.text = "Airsoft\nA burst of 4 clicks each 3 seconds\n[On Player Click]"
		3: buy.text = "BB Gun\nA burst of 4 clicks each 2 seconds\n[On Player Click]"
		4: buy.text = "Real Weaponary\nA burst of 4 clicks EACH second!\n[On Player Click]"
		5: buy.text = "Machine-Gun\nA burst of 5 clicks EACH second!\n[On Player Click]"
		6: buy.text = "Greedy Scythe\nA burst of 10 clicks EACH second!\n[On Player Click]"
		7: buy.text = "EYE OF OBVILION\nINFINITE CLICKS, NO COOLDOWN.\n[On Player Click]"
		8: queue_free()
	
	price.text =  Formatter.format_number(Items.click_burst_price) + " Points"

func _physics_process(_delta: float) -> void:
	if GlobalVars.score < Items.click_burst_price:
		buy.disabled = true
	else:
		buy.disabled = false

func _on_button_pressed() -> void:
	if GlobalVars.score >= Items.click_burst_price:
		AudioPlayer.bought_item()
		GlobalVars.score -= Items.click_burst_price
		Items.click_burst_acquired += 1
		Items.click_burst_price = 5750 * roundf(pow(14, Items.click_burst_acquired))
		
	match Items.click_burst_acquired:
		1: 
			buy.text = "Pressure Watergun\nA burst of 3 clicks each 4 seconds\n[On Player Click]"
			GlobalVars.click_burst_cooldown = 5
		2: 
			buy.text = "Airsoft\nA burst of 4 clicks each 3 seconds\n[On Player Click]"
			GlobalVars.click_burst_cooldown = 4
		3: 
			buy.text = "BB Gun\nA burst of 4 clicks each 2 seconds\n[On Player Click]"
			GlobalVars.click_burst_cooldown = 3
		4: 
			buy.text = "Real Weaponary\nA burst of 4 clicks EACH second!\n[On Player Click]"
			GlobalVars.click_burst_cooldown = 2
		5: 
			buy.text = "Machine-Gun\nA burst of 5 clicks EACH second!\n[On Player Click]"
			GlobalVars.click_burst_cooldown = 1
		6: 
			buy.text = "Greedy Scythe\nA burst of 10 clicks EACH second!\n[On Player Click]"
			GlobalVars.click_burst_cooldown = 1
		7: 
			buy.text = "EYE OF OBVILION\nINFINITE CLICKS, NO COOLDOWN.\n[STACKS INFINITELY]"
			GlobalVars.click_burst_cooldown = 1
		8: 
			GlobalVars.click_burst_cooldown = 0
			queue_free()
	price.text =  Formatter.format_number(Items.click_burst_price) + " Points"
