extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var actuallyNewText=''
onready var Display=$VBoxContainer/Display
onready var Entry=$VBoxContainer/HBoxContainer/TextEntry
onready var PButton=$VBoxContainer/HBoxContainer/TextureButton
onready var OkLabel=$VBoxContainer/HBoxContainer/Label
#onready var StoryNode=$Story

var file=File.new()




var Questions=["name","nick name","age"]
var Story=""
#var childrenSize=$Story
#var randomChild=randi() % childrenSize
var gameEnded=false

var ans=[]
var counter:int=0

func _ready():
	
	var json_data=_returnJsonArray()
	var jsonArraySize=json_data.size()
	var randomIndex=_randomIndex(jsonArraySize)
	Questions=json_data[randomIndex].question
	Story=json_data[randomIndex].story
	
	
	Display.text="what is your "+Questions[counter]
	Entry.grab_focus()
	#print(ans)
	
	
	#$VBoxContainer/Display.text="hello world"

func _returnJsonArray():
	file.open("qna.json",File.READ)
	var text=file.get_as_text()
	return parse_json(text)


func _randomIndex(index:int):
	return randi() % index


func _on_TextEntry_text_changed(new_text):
	#$VBoxContainer/Display.text=new_text
	actuallyNewText=new_text
	
func _on_TextureButton_pressed():
	if(gameEnded==true):
		get_tree().reload_current_scene()
	elif(counter<Questions.size()-1):
		ans.append(actuallyNewText)
		counter=counter+1
		print(counter)
		Display.text="what is your "+Questions[counter]
	else:
		ans.append(actuallyNewText)
		PButton.visible=true
		Entry.queue_free()
		#PButton.show()
		#print(ans)
		#print(Story)
		Display.text=Story % ans
		gameEnded=true
		OkLabel.text="Again"
	
	#pass # Replace with function body.
