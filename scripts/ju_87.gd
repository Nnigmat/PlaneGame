extends Spatial

signal bullet_faced

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$elisa2.transform = $elisa2.transform.rotated(Vector3(0, 0, 1), 7 * PI * delta)

func _on_PlaneArea_area_entered(area):
	if area.get_name() == 'EnemyBulletArea':
		area.get_parent().get_parent().remove_child(area.get_parent())
		get_tree().get_root().get_node('Game')._on_health_loss()
		
		
func _destroy():
	var parent = get_parent()
	if parent:
		parent.remove_child(self)


	
