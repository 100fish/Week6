extends Label

var scorePath: String = "res://Scores.txt"
var namePath: String = "res://Names.txt"

var scores: Array[String] = []
var names: Array[String] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scores.resize(10)
	names.resize(10)
	
	#text = read_entire_file("res://Scores.txt")
	read_file_line_by_line(scorePath, scores)
	read_file_line_by_line(namePath, names)
	
	text = names[0] + ": " + scores[0] + "\n" + names[1] + ": " + scores[1] + "\n" + names[2] + ": " + scores[2] + "\n" + names[3] + ": " + scores[3] + "\n" + names[4] + ": " + scores[4] + "\n" + names[5] + ": " + scores[5] + "\n" + names[6] + ": " + scores[6] + "\n" + names[7] + ": " + scores[7] + "\n" + names[8] + ": " + scores[8] + "\n" + names[9] + ": " + scores[9]
	
	pass # Replace with function body.

func add_new_score(newScore: int):
	var currentScores = scores
	var currentNames = names
	
	for i in currentScores:
		i = int(i)
	
	#currentScores.append(newScore)
	
	#sort names by scores
	currentNames.sort_custom(func(a, b):
		return currentScores.find(a) < currentScores.find(b))
	
	#sort scores
	currentScores.sort()
	
	for i in currentScores:
		i = String(i)

func save_arrays_to_file(scoreArray: Array, nameArray: Array) -> void:
	# Open the file for writing (creates the file if it doesn't exist)
	var file = FileAccess.open(scorePath, FileAccess.WRITE)
	
	if file:
		for element in scoreArray:
			# Convert the element to a string and save it as a line
			file.store_line(str(scoreArray))
		
		file.close() # Close the file when done
		print("File saved successfully!")
	else:
		print("Failed to open file. Error code: ", FileAccess.get_open_error())
	
	file = FileAccess.open(namePath, FileAccess.WRITE)
	
	if file:
		for element in nameArray:
			# Convert the element to a string and save it as a line
			file.store_line(str(nameArray))
		
		file.close() # Close the file when done
		print("File saved successfully!")
	else:
		print("Failed to open file. Error code: ", FileAccess.get_open_error())


func read_file_line_by_line(file_path: String, array: Array):
	if not FileAccess.file_exists(file_path):
		return
	var file = FileAccess.open(file_path, FileAccess.READ)
	
	# Loop until the End Of File (EOF) is reached
	var i: int = 0
	while not i == 10:
		var line = file.get_line()
		array[i] = line
		
		i += 1

func read_entire_file(file_path: String) -> String:
	# Check if the file actually exists first
	if not FileAccess.file_exists(file_path):
		print("File does not exist!")
		return ""
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	
	var content = file.get_as_text()
	
	return content
