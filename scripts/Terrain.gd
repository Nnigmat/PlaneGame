extends Spatial

var width;
var height;

var heightData = {}

var vertices = PoolVector3Array()
var UVs = PoolVector2Array()
var normals = PoolVector3Array()

var tmpMesh = Mesh.new()

func _ready():
	var heightmap = $SpriteInstance.texture
	yield(heightmap, "changed")
	heightmap = heightmap.get_data()
	width = $SpriteInstance.texture.get_width()
	height = $SpriteInstance.texture.get_height()
	
	# parse image file
	for x in range(0,width):
		for y in range(0,height):
			heightData[Vector2(x,y)] = heightmap.get_pixel(x,y).r*20
	
	# generate terrain
	for x in range(0,width-1):
		for y in range(0,height-1):
			createQuad(x,y)
	
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	st.set_material(load("res://terrain_material.tres"))
	
	for v in vertices.size():
		st.add_color(Color(1,1,1))
		st.add_uv(UVs[v])
		st.add_normal(normals[v])
		st.add_vertex(vertices[v])
	
	st.commit(tmpMesh)
	
	$MeshInstance.mesh = tmpMesh
	var shape = ConcavePolygonShape.new()
	shape.set_faces(tmpMesh.get_faces())
	$MeshInstance/StaticBody/CollisionShape.shape = shape

func createQuad(x,y):
	var vert1 # vertex positions (Vector2)
	var vert2
	var vert3
	
	var side1 # sides of each triangle (Vector3)
	var side2
	
	var normal # normal for each triangle (Vector3)
	
	# triangle 1
	vert1 = Vector3(x,heightData[Vector2(x,y)],-y)
	vert2 = Vector3(x,heightData[Vector2(x,y+1)],-y-1)
	vert3 = Vector3(x+1,heightData[Vector2(x+1,y+1)],-y-1)
	vertices.push_back(vert1)
	vertices.push_back(vert2)
	vertices.push_back(vert3)
	
	UVs.push_back(Vector2(vert1.x/10, -vert1.z/10))
	UVs.push_back(Vector2(vert2.x/10, -vert2.z/10))
	UVs.push_back(Vector2(vert3.x/10, -vert3.z/10))
	
	side1 = vert2-vert1
	side2 = vert2-vert3
	normal = side1.cross(side2)
	
	for i in range(0,3):
		normals.push_back(normal)
	
	# triangle 2
	vert1 = Vector3(x,heightData[Vector2(x,y)],-y)
	vert2 = Vector3(x+1,heightData[Vector2(x+1,y+1)],-y-1)
	vert3 = Vector3(x+1,heightData[Vector2(x+1,y)],-y)
	vertices.push_back(vert1)
	vertices.push_back(vert2)
	vertices.push_back(vert3)
	
	UVs.push_back(Vector2(vert1.x/10, -vert1.z/10))
	UVs.push_back(Vector2(vert2.x/10, -vert2.z/10))
	UVs.push_back(Vector2(vert3.x/10, -vert3.z/10))
	
	side1 = vert2-vert1
	side2 = vert2-vert3
	normal = side1.cross(side2)
	
	for i in range(0,3):
		normals.push_back(normal)
