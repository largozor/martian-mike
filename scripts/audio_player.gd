extends Node

var hurt = preload("res://assets/audio/hurt.wav")
var jump = preload("res://assets/audio/jump.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_sfx(effect: String) -> void:

	var player = AudioStreamPlayer.new()
	
	if effect == "hurt":
		player.stream = hurt
	elif effect == "jump":
		player.stream = jump
	else:
		print("Invalid sound name: " + effect)

	player.name = "SFX"
	
	add_child(player)
	player.play()
	
	await player.finished
	player.queue_free()
	
	
