extends Button
@onready var grid := $"../../../Inventory/MarginContainer/GridContainer"


var item_slots: Array[Panel]

var letter_bag: Array[String] = []

var letters: Array[String] = [
	".png",
	"A.png", "B.png", "C.png", "D.png", "E.png", "F.png", "G.png", "H.png", "I.png",
	"J.png", "K.png", "L.png", "M.png", "N.png", "O.png", "P.png", "Q.png", "R.png",
	"S.png", "T.png", "U.png", "V.png", "W.png", "X.png", "Y.png", "Z.png"
]

var letter_count := [
	2,
	9, 2, 2, 4, 12, 2, 3, 2, 9,
	1, 1, 4, 2, 6, 8, 2, 1, 6,
	4, 6, 4, 2, 2, 1, 2, 1
]

var random_num := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random_num.randomize()
	
	item_slots = []
	for child in grid.get_children():
		if child is Panel:
			item_slots.append(child)
	
	letter_bag_maker()
	random_letter()		
			
func letter_bag_maker():
	for i in range(27):
		for j in range(letter_count[i]):
			letter_bag.append(letters[i])		

func random_letter():
	
	for slot in item_slots:
		var icon: TextureRect = slot.get_node("TextureRect")
		if letter_bag.size() == 0:
			return
		
		if icon.texture == null:
			var index = random_num.randi_range(0, letter_bag.size() - 1)
			var path = 	"res://Letter Tiles/letter_" + letter_bag[index]
			icon.texture = load(path)
			letter_bag.remove_at(index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _pressed():
	random_letter()
