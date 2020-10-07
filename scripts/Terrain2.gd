extends Spatial

export(OpenSimplexNoise) var noise
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var step = 2;
var shift = 0;
var material;

# Called when the node enters the scene tree for the first time.
func _ready():
	material = $MeshInstance.mesh.surface_get_material(0);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shift += 0.3 * step;
	$MeshInstance.mesh.surface_get_material(0).set_shader_param("shift", shift)
