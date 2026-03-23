extends Node3D

func _ready():
	# Get Submit Button
	var submit_button = $Control/Panel/SubmitButton

	# Get the TileInventory scene instance
	var tile_inventory = $TileInventory

	# Get the Inventory Button inside TileInventory
	var inventory_button = tile_inventory.get_node("Control/Panel/Button")  # path inside the child scene
	
	print(inventory_button)
	# Connect the signal
	#submit_button.connect("submit_done", inventory_button, "random_letter")
