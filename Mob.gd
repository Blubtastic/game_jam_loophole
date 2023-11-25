extends CharacterBody3D

signal squashed

@export var speed = 6
@export var view_distance: int = 8
var viewCone: ShapeCast3D

func _ready():
	viewCone = get_node("Pivot/Character/ShapeCast3D")

func _physics_process(_delta):
	if viewCone.is_colliding():
		var target = viewCone.get_collision_point(0)
		look_at_from_position(
			Vector3(self.position),
			Vector3(target.x, self.position.y, target.z),
			Vector3.UP)
		velocity = Vector3.FORWARD * speed
		velocity = velocity.rotated(Vector3.UP, rotation.y)
		move_and_slide()

func squash():
	squashed.emit()
	queue_free()
