extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_time_label(value: int):
	$TimeLabel.text = "TIME = " + str(value)
	if 5 < value and value <= 10:
		$TimeLabel.label_settings.font_color = Color.ORANGE
	elif 2 < value and value <= 5:
		$TimeLabel.label_settings.font_color = Color.ORANGE_RED
	elif value <= 2:
		$TimeLabel.label_settings.font_color = Color.RED
	else:
		$TimeLabel.label_settings.font_color = Color.WHITE
