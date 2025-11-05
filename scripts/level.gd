extends Node2D

@export var next_level: PackedScene = null
@export var level_time = 5
@export var is_final_level = false

@onready var start_position = $StartPosition
@onready var exit = $Exit
@onready var death_zone = $DeathZone
@onready var hud = $UILayer/HUD
@onready var ui_layer  = $UILayer

var player = null

var timer_node = null
var time_left
var win = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	if player != null:
		player.global_position = start_position.get_spawn_position()
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		# trap.connect("touched_player", _on_trap_touched_player)
		trap.touched_player.connect(_on_trap_touched_player)
	exit.body_entered.connect(_on_exit_body_entered)
	death_zone.body_entered.connect(_on_death_zone_body_entered)
	
	time_left = level_time
	hud.set_time_label(time_left)
	
	timer_node = Timer.new()
	timer_node.name = "Level_Timer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	timer_node.start()


func _on_level_timer_timeout()-> void:
	if win == false:
		time_left -= 1
		hud.set_time_label(time_left)
		print(time_left)
		
		if time_left < 0:
			reset_player()
			time_left = level_time
			hud.set_time_label(time_left)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_death_zone_body_entered(body: Node2D) -> void:
	reset_player()
	


func _on_trap_touched_player() -> void:
	reset_player()

func reset_player() -> void:
	player.velocity = Vector2.ZERO
	player.global_position = start_position.get_spawn_position()
	
func _on_exit_body_entered(body):
	if body is Player:
		win = true
		exit.animate()
		if is_final_level or next_level != null:
			player.active = false
			await get_tree().create_timer(1.5).timeout
			get_tree().change_scene_to_packed(next_level)
			if is_final_level:
				ui_layer.show_win_screen(true)
