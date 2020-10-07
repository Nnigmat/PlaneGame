extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ju_87/elisa2.transform = $ju_87/elisa2.transform.rotated(Vector3(0, 0, 1), 7 * PI * delta)
