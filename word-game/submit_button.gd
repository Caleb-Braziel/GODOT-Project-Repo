extends Button

@onready var board: GridContainer = $"../../../Board Container/MarginContainer/Board"
@onready var rando_button: Button = $"../../../TileInventory/Control/Button Holder/Button"


var letter_values := [
	0, 
	1, 3, 3, 2, 1, 4, 2, 4, 1,
	8, 5, 1, 3, 1, 1, 3, 10, 1,
	1, 1, 1, 4, 4, 8, 4, 10
]

var prev_matrix: Array = []
var current_matrix: Array = []
var slot_matrix: Array = []  # matrix of ItemSlots

func _ready() -> void:
	
	#var inventory_button = $"../../../TileInventory/Control/Button Holder/Button"

	#self.connect("submit_done", inventory_button, "random_letter")
	
	build_matrix()
	prev_matrix = []
	for row in current_matrix:
		prev_matrix.append(row.duplicate())

func build_matrix():
	current_matrix.clear()
	slot_matrix.clear()

	for row in board.get_children():
		var row_textures: Array = []
		var row_slots: Array = []

		for board_tile in row.get_children():
			var outer_texture = board_tile.get_node("TextureRect")
			var item_slot = outer_texture.get_node("ItemSlot")
			row_slots.append(item_slot)

			var texture_rect = item_slot.get_node("TextureRect")
			row_textures.append(texture_rect.texture)

		current_matrix.append(row_textures)
		slot_matrix.append(row_slots)

	#print("Current matrix:", current_matrix)

func submit():
	build_matrix()
	var changed_slots: Array = []

	for i in range(current_matrix.size()):
		var cur_row = current_matrix[i]
		var prev_row = prev_matrix[i]

		for j in range(cur_row.size()):
			if cur_row[j] != prev_row[j]:
				# Access the corresponding ItemSlot
				var changed_slot = slot_matrix[i][j]
				changed_slots.append(changed_slot)
				
				changed_slot.submitted = true
				
				print("Changed slot at row", i + 1, "col", j + 1, "->", changed_slot)


	prev_matrix.clear()
	for row in current_matrix:
		
		prev_matrix.append(row.duplicate())
	

func _pressed():
	submit()
	rando_button.random_letter()
	
