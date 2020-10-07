extends Node2D

onready var Ball : Sprite  = get_node("Ball")

export(OpenSimplexNoise) var perlin_noise
export(float) var amplitude = 5.0
export(float) var speed = 2.0

var width
var height

var time : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var projectResolution=Vector2(ProjectSettings.get_setting("display/window/size/width") ,ProjectSettings.get_setting("display/window/size/height"))
	width = projectResolution.x
	height = projectResolution.y
	var perlin_value = perlin_noise.get_noise_2d(time, 0.0)
	self.Ball.set_position(Vector2(perlin_value, 10))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += speed
	var perlin_value = perlin_noise.get_noise_2d(time, 0.0)
	Ball.set_position(Vector2(width / 2 + perlin_value*amplitude, height / 2))
