extends StaticBody2D

@onready var spawn_position = $SpawnPosition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_spawn_position() -> Vector2:
	return spawn_position.global_position
