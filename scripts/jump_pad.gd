extends Area2D

@export var jump_force = -500

@onready var animated_sprite = $AnimatedSprite2D
@onready var sfx = $"/root/AudioPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		animated_sprite.play("jump")
		body.jump(jump_force)
		sfx.play_sfx("jump")
