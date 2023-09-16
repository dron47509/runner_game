extends TileMap

@export var real_scale = 3
var paths_dots = []
var number_card = 1
# Called when the node enters the scene tree for the first time.

func _ready():
	scale = Vector2(real_scale, real_scale)
	initialize_path()


func initialize_path():
	var tiles = get_used_cells_by_id(0, 1)
	var start_point = get_used_cells_by_id(0, 0)[0]
	paths_dots.append(Vector2i(start_point.x, start_point.y))
	for x in range(len(get_used_cells_by_id(0, 1))):
		for cell in range(len(tiles)):
			if x == 0 and tiles[cell].y == paths_dots[-1].y and tiles[cell].x-1 == paths_dots[-1].x:
				paths_dots.append(Vector2i(tiles[cell].x, tiles[cell].y))
				tiles.pop_at(cell)
				break
			elif x == 0 and tiles[cell].y-1 == paths_dots[-1].y and tiles[cell].x == paths_dots[-1].x:
				paths_dots.append(Vector2i(tiles[cell].x, tiles[cell].y))
				tiles.pop_at(cell)
				break
			elif x != 0 and tiles[cell].y-1 == paths_dots[-1].y and tiles[cell].x == paths_dots[-1].x:
				paths_dots.append(Vector2i(tiles[cell].x, tiles[cell].y))
				tiles.pop_at(cell)
				break
			elif x != 0 and tiles[cell].y+1 == paths_dots[-1].y and tiles[cell].x == paths_dots[-1].x:
				paths_dots.append(Vector2i(tiles[cell].x, tiles[cell].y))
				tiles.pop_at(cell)
				break
			elif x != 0 and tiles[cell].y == paths_dots[-1].y and tiles[cell].x-1 == paths_dots[-1].x:
				paths_dots.append(Vector2i(tiles[cell].x, tiles[cell].y))
				tiles.pop_at(cell)
				break
			elif x != 0 and tiles[cell].y == paths_dots[-1].y and tiles[cell].x+1 == paths_dots[-1].x:
				paths_dots.append(Vector2i(tiles[cell].x, tiles[cell].y))
				tiles.pop_at(cell)
				break
	paths_dots.append(Vector2i(start_point.x, start_point.y))
	for cell in paths_dots:
		# Добавляем точки вдоль циклической дороги (пример)
		$Path2D.curve.add_point(Vector2(cell.x*16+8, cell.y*16+8))  # Первая точка


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("left_click"):
		if !(local_to_map(get_viewport().get_mouse_position())/real_scale in paths_dots) and number_card !=0:
			set_cell(0, local_to_map(get_viewport().get_mouse_position())/real_scale, 2, Vector2i(1, 2))
			#number_card = 0
	var water_power = 0
	var cicle_array = [-1, 0, 1]
	for x in get_used_cells_by_id(0, 2):
		for y in get_used_cells_by_id(0, 2):
			for z in cicle_array:
				for d in cicle_array:
					if x.x + z == y.x and x.y + d == y.y:
						if z == 0 and d == 0:
							water_power += 1
						else:
							water_power += 0.5
					
				
			
	$Label.text = str(water_power)


func _on_control_change_card(number):
	number_card = number # Replace with function body.
