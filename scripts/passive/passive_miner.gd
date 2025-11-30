extends Node

var acc = 0.0

func _process(delta: float) -> void:
	if Items.passive_miner_acquired > 0:
			acc += delta
			if acc >= 1.0:
				acc = 0
				GlobalVars.score += Items.passive_miner_power * Items.passive_miner_acquired * Items.click_mult_power
			
