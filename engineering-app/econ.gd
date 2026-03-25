extends Panel

var DIR = OS.get_executable_path().get_base_dir()
var interpreter_path: String
var script_path: String
@onready var answer_box: LineEdit = $"../Question Menu/Table/AnswerBox"
@onready var subject_menu: Panel = $"."
@onready var question_menu: Panel = $"../Question Menu"

@onready var table_back: ColorRect = $"../Question Menu/Table/TableBack"
@onready var table_grid: GridContainer = $"../Question Menu/Table/TableBack/TableGrid"

@onready var correct: Panel = $"../Question Menu/Correct"
@onready var incorrect: Panel = $"../Question Menu/Incorrect"
@onready var show_ans: Panel = $"../Question Menu/Show_Ans"

@onready var choice_1_TF: Button = $"../Question Menu/TrueFalse/choice_container/Choice1"
@onready var choice_2_TF: Button = $"../Question Menu/TrueFalse/choice_container/Choice2"

@onready var true_false: Control = $"../Question Menu/TrueFalse"
@onready var choice_container: GridContainer = $"../Question Menu/TrueFalse/choice_container"

@onready var table: VBoxContainer = $"../Question Menu/Table"

@onready var reveal: Button = $"../Question Menu/Question Buttons/Reveal"
@onready var hide: Button = $"../Question Menu/Question Buttons/Hide"

# Can optimize this section to just get children of certain variables instead of preloading all


var mult_choice = -1
var correct_choice = -1



var output = []
var answer = ""

@onready var question: Label = $"../Question Menu/Question"

func _ready() -> void:
	question_menu.visible = false
	subject_menu.visible = true
	table_back.visible = false
	if OS.has_feature("standalone"):
		# Exported build: paths relative to executable
		interpreter_path = DIR.path_join("PythonScripts/venv/Scripts/python.exe")
		script_path = DIR.path_join("PythonScripts/Engr_Econ_no_TK.py")
	else:
		# Editor: use res:// paths
		interpreter_path = ProjectSettings.globalize_path("res://PythonScripts/venv/Scripts/python.exe")
		script_path = ProjectSettings.globalize_path("res://PythonScripts/Engr_Econ_no_TK.py")
	#OS.execute(interpreter_path, [script_path, "", "", ""], output, false)  # false = non-blocking
	
	choice_1_TF.pressed.connect(func(): set_choice(1))
	choice_2_TF.pressed.connect(func(): set_choice(2))

	
func set_choice(value):	
	mult_choice = value
	_choice_submit()

func _choice_submit():
	#print(mult_choice)
	#print(int(answer))
	if mult_choice == int(answer):
		_right_answer()
	else:
		_wrong_answer()	
		
	

func _question_maker(minimum: int, maximum: int):
	output = []
	OS.execute(interpreter_path, [script_path, minimum, maximum], output, false)  # false = non-blocking
	var question_num = 0
	#print(output)
	output = output[0].split('@')
	#print(output[0])
	#print()
	question_num = int(output[0])
	print(question_num)
	question.text = output[1]
	
	#print(question.text)
	
	show_ans.visible = false
	reveal.visible = true
	hide.visible = false
	
	
	#print(len(output))
	var q_label = question_menu.get_child(0)
	
	table_back.custom_minimum_size = Vector2(339, 172)
	_clear_cells()
	
	
	if question_num == 8:
		table_grid.columns = 4
	if question_num == 10:
		table_grid.columns = 2
		q_label.set_position(Vector2(-378.5, -350))
	else:
		q_label.set_position(Vector2(-378.5, -300))
	if question_num == 11:
		table_grid.columns = 2	
	
	if question_num == 19:
		table.set_position(Vector2(-146.5, 0))
	else:
		table.set_position(Vector2(-146.5, -121.5))		

	
	if len(output) > 3:

		for i in range(len(output)):
			if str(output[i]) == "TABLE_START":
				#print("Table Detected")
				var j = i + 1
				var temp
				table_back.visible = true
				while output[j] != "TABLE_END":
					if j - i - 1 > 16:
						print("ERROR: EXCEEDED TABLE LENGTH")
						break
					else:	
						temp = table_grid.get_child(j - i - 1)
						temp.visible = true
						temp.text = output[j]
					j += 1	
				table_back.custom_minimum_size = Vector2(0 , (44 * int((j - i - 1) / table_grid.columns)))
	
	answer = output[-1]
	_clear_menu()
	answer_box.visible = true
	
	if question_num == 7: # maybe move question specific stuff to new function
		answer_box.visible = false
		true_false.visible = true
		choice_1_TF.text = "Economically Justified"
		choice_2_TF.text = "Not Economically Justified"
		
		choice_1_TF.custom_minimum_size = Vector2(350, 46)
		choice_2_TF.custom_minimum_size = Vector2(350, 46)
		choice_container.columns = 1
		true_false.set_position(Vector2(-146, -46))
		
		
		correct_choice = int(answer)
	
	if question_num == 8: # maybe move question specific stuff to new function
		answer_box.visible = false
		true_false.visible = true
		choice_1_TF.text = "Alternative A"
		choice_2_TF.text = "Alternative B"
		choice_container.columns = 2
		true_false.set_position(Vector2(-146, 100))
		
		
		
		choice_1_TF.custom_minimum_size = Vector2(350, 46)
		choice_2_TF.custom_minimum_size = Vector2(350, 46)
		
		correct_choice = int(answer)	



func _on_submit_pressed():
	var user_answer = answer_box.text
	var ans = answer.replace(" ", "").replace("\t", "").replace("\n", "").replace("\r", "")
	print(ans)
	if 	user_answer == "":
		pass
	else:	
		if int(user_answer) != 0 or user_answer == "0":
			user_answer = float(user_answer)	

		
		if int(ans) != 0 or ans == "0":
			ans = float(ans)
		
		print(ans)
		#print(user_answer)
		
		if typeof(user_answer) != typeof(ans):
			print("type mismatch")
			_wrong_answer()
		else:
			if typeof(ans) == TYPE_FLOAT:
				print("precheck")
				var check = num_check(user_answer, ans)
				
				if check:
					_right_answer()
				else:
					_wrong_answer()	
				
			elif typeof(ans) == TYPE_STRING:
				if user_answer.to_lower() == ans.to_lower():
					_right_answer() 
				else:
					_wrong_answer()	
			
			else:
				print("ERROR: WRONG TYPE FOR ANSWER")			

func _right_answer():
	correct.visible = true
	incorrect.visible = false
	await get_tree().create_timer(1.0).timeout
	correct.visible = false	# create fade out transition later
	# maybe lock the answer if entered correct choice

func _wrong_answer():
	correct.visible = false
	incorrect.visible = true
	await get_tree().create_timer(1.0).timeout
	incorrect.visible = false

func _clear_menu():
	subject_menu.visible = false
	question_menu.visible = true
	true_false.visible = false

func _clear_cells():
	for i in range(16):
		table_grid.get_child(i).text = ""
		table_grid.get_child(i).visible = false

func num_check(user_answer, ans):
	var tolerance = 0.05  # 5% tolerance by default
	var temp = ans
	var sig_figs = 3

	if temp == 0:
		return int(user_answer) == int(temp) 
	else:	
		while temp < 0.001: # 0.01 to line up with 3 sig figs
			sig_figs += 1
			temp *= 10
			tolerance += 0.05  # Increase tolerance for smaller numbers
			print(temp)

		if (user_answer < (ans + (tolerance * ans))) and (user_answer > (ans - (tolerance * ans))):
			return true
		else:     
			return false 


func _on_reveal_pressed() -> void:
	print(answer)
	show_ans.get_child(0).text = answer
	if show_ans.visible:
		show_ans.visible = false
		reveal.visible = true
		hide.visible = false
	else:
		show_ans.visible = true
		reveal.visible = false
		hide.visible = true


func _on_new_q_pressed() -> void:
	subject_menu.visible = true
	table_back.visible = false
	question_menu.visible = false
	answer_box.text = ""
	


############################################### Function Buttons ###############################################
	
func _on_single_pay_pressed() -> void:
	_question_maker(0, 1)
	
func _on_uniform_pressed():
	_question_maker(2, 5)
	
func _on_salvage_pressed():
	_question_maker(6, 6)
	
func _on_cost_benefit_pressed():
	_question_maker(7, 8) 
	
func _on_payback_pressed():
	_question_maker(9, 10)

func _on_breakeven_pressed():
	_question_maker(11, 11)
	
func _on_ror_pressed():
	_question_maker(12, 12) # fix other ROR versions
	
func _on_rates_pressed():
	_question_maker(13, 14)
	
func _on_inflation_pressed():
	_question_maker(15, 15)
	
func _on_mortgage_pressed():
	_question_maker(16, 17)

func _on_sink_fund_pressed():
	_question_maker(18, 18)
	
func _on_sld_pressed(): 
	_question_maker(19, 19) # fix formatting

func _on_random_pressed():
	_question_maker(0, 19)
