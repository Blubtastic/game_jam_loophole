extends Node

@export var mob_scene: PackedScene
var camera: Marker3D

func _ready():
	$UserInterface/Retry.hide()
	camera = get_node("Player/CameraPivot")

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	var player_position = $Player.position
#	mob.initialize(mob_spawn_location.position, player_position)
#
#	add_child(mob)
#
#	mob.squashed.connect($UserInterface/ScoreLabel._on_mob_squashed.bind())

func _process(delta):
	# lock camera Y-axis
	if camera != null:
		var position = camera.get_global_position()
		position.y = 0
		camera.set_global_position(position)

func _on_player_hit():
	$UserInterface/Retry.show()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		# This restarts the current scene.
		get_tree().reload_current_scene()

