extends CharacterBody3D

signal squashed

@export var speed = 6
@export var view_distance: int = 8
var viewCone: ShapeCast3D
var path: PathFollow3D
var patroll: bool

func _ready():
	viewCone = get_node("Pivot/Character/ShapeCast3D")
	path = get_parent()

func _physics_process(_delta):
	patroll = true
	if viewCone.is_colliding():
		var collidedObject = viewCone.get_collider(0)
		if collidedObject != null && collidedObject.name == "Player":
			var target = viewCone.get_collision_point(0)
			var space_state = get_world_3d().direct_space_state
			var query = PhysicsRayQueryParameters3D.create(self.global_position, target)
			query.collide_with_bodies = true
			var result = space_state.intersect_ray(query)
			if not result.is_empty() && result["collider"].name == "Player":
				patroll=false
				target.y = self.global_position.y
				look_at_from_position(
					Vector3(self.global_position),
					Vector3(target),
					Vector3.UP)
	
	if patroll:
		path.progress += speed * _delta
		if rotation_degrees != Vector3.ZERO:
			rotation_degrees = lerp(rotation_degrees, Vector3.ZERO, 0.5)
		

func squash():
	squashed.emit()
	queue_free()
