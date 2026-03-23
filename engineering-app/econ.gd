extends Panel

var DIR = OS.get_executable_path().get_base_dir()
var interpreter_path: String
var script_path: String
@onready var answer_box: LineEdit = $"../Question Menu/Table/AnswerBox"
@onready var subject_menu: Panel = $"."
@onready var question_menu: Panel = $"../Question Menu"

@onready var table_back: ColorRect = $"../Question Menu/Table/TableBack"
@onready var table_grid: GridContainer = $"../Question Menu/Table/TableBack/GridContainer"

@onready var correct: Panel = $"../Question Menu/Correct"
@onready var incorrect: Panel = $"../Question Menu/Incorrect"



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
	

func _question_maker(minimum: int, maximum: int):
	output = []
	OS.execute(interpreter_path, [script_path, minimum, maximum], output, false)  # false = non-blocking
	output = output[0].split('@')
	#print(output[1])
	question.text = output[0]
	
	#print(len(output))
	
	if len(output) > 2: # CHANGE LATER TO FIND TABLE_START INSTEAD OF SET INDEX
		#print("step 1")
		
		if str(output[1]) == "TABLE_START":
			print("step 2")
			print("ERROR: TABLE LOGIC NOT YET IMPLEMENTED")
			"""var i = 2
			var temp
			table_back.visible = true
			while output[i] != "TABLE_END":
				#print(i)
				print(output[i])
				#print("test" + output[i] + "test")
				if i > 18:
					print("ERROR: EXCEEDED TABLE LENGTH")
					break
				else:	
					temp = table_grid.get_child(i - 2)
					print(temp)
					temp.text = output[i]
				i += 1	"""
					
	
	answer = output[-1]
	_clear_menu()



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

func num_check(user_answer, ans):
	var tolerance = 0.05  # 5% tolerance by default
	var temp = ans
	var sig_figs = 3
	#print("num check")
	#print(user_answer)
	#print(ans)
	#print(temp)
	if temp == 0:
		return int(user_answer) == int(temp) 
	else:	
		while temp < 0.001: # 0.01 to line up with 3 sig figs
			sig_figs += 1
			temp *= 10
			tolerance += 0.05  # Increase tolerance for smaller numbers
			print(temp)
		#print("left")
		#print((ans + (tolerance * ans)))
		#print("right")
		#rint((ans - (tolerance * ans)))
		if (user_answer < (ans + (tolerance * ans))) and (user_answer > (ans - (tolerance * ans))):
			return true
		else:     
			return false 


func _on_reveal_pressed() -> void:
	print(answer)


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
	_question_maker(7, 8) # remember table logic
	
func _on_payback_pressed():
	_question_maker(9, 10)

func _on_breakeven_pressed():
	_question_maker(11, 11) # incorrect number of params
	
func _on_ror_pressed():
	_question_maker(12, 12)
	
func _on_rates_pressed():
	_question_maker(13, 14) # incorrect number of params
	
func _on_inflation_pressed():
	_question_maker(15, 15)
	
func _on_mortgage_pressed():
	_question_maker(16, 17) # fix formatting

func _on_sink_fund_pressed():
	_question_maker(18, 18) # incorrect number of params
	
func _on_sld_pressed(): 
	_question_maker(19, 19) # fix formatting

func _on_random_pressed():
	_question_maker(0, 19)
