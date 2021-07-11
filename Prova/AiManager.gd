extends Node

var SAVE_FOLDER: String = "user://debug/AI"
var SAVE_NAME_TEMPLATE: String = "input.lp"
var absolutePath :String
var pathTaken = false
var done = false

func save(content):
	var directory: Directory = Directory.new()
	if not directory.dir_exists(SAVE_FOLDER):
		directory.make_dir_recursive(SAVE_FOLDER)
	var save_path = SAVE_FOLDER.plus_file(SAVE_NAME_TEMPLATE)
	var file = File.new()
	file.open(save_path, file.WRITE)
	if !pathTaken:
		absolutePath = file.get_path_absolute()
		absolutePath.erase(len(absolutePath)-9,9)
		pathTaken = true
	file.store_string(content)
	file.close()
	
	
	
func read():
	var output = []
	#/C run command and then terminate
	OS.execute("cmd.exe", ["/C", "cd "+absolutePath+" && clingo SpaceInvadersAi.lp input.lp --verbose=0 --outf=2"], true,output)
	output = str(JSON.parse(output[0]).result)

	var index = output.find_last("shoot") + 6
	var value = ""
	while output[index] != ',':
		value += output[index]
		index += 1

	value = int(value)
	return value
