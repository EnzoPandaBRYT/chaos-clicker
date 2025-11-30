extends CanvasLayer

@onready var score = $score
@onready var pps = $pps

var time = 0.0
var expire = 0.0

func _process(delta: float) -> void:
	score.text = Formatter.format_number(GlobalVars.score)
	
	if GlobalVars.avg_score != 0.0:
		time += delta
		if time >= 1.0:
			pps.text = Formatter.format_number(roundf(GlobalVars.avg_score/time)) + "/s"
			time = 0
			GlobalVars.avg_score = 0
	else:
		time += delta
		if time >= 1.0:
			pps.text = Formatter.format_number(0) + "/s"
			time = 0
