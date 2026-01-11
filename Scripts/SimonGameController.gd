extends Node

#Simon Game Variables
var correct_sequence: Array[int] = []
var sequence_difficulty: Array[int] = [3,5,7]
var actual_difficulty: int = 0
var player_sequence_size: int = 0

#SimonButtons References
@onready var simon_start_button = $"../Sorvetes-Interactable/Simon-Start"
@onready var light_blue = $"../Sorvetes-Interactable/Light-Blue"
@onready var red = $"../Sorvetes-Interactable/Red"
@onready var pink = $"../Sorvetes-Interactable/Pink"
@onready var yellow = $"../Sorvetes-Interactable/Yellow"
@onready var brown = $"../Sorvetes-Interactable/Brown"
@onready var dark_blue = $"../Sorvetes-Interactable/Dark-Blue"

#Prize Reference
const PRIZE_ITEM = preload("res://Interaction Components/Components/Vela.tscn")

func _ready() -> void:
	if !GameManager.simon_completed:
		var simon_buttons = [light_blue, red, pink, yellow, brown, dark_blue]
		simon_start_button.was_interacted.connect(start_game)
		for simon_button in simon_buttons:
			simon_button.was_interacted.connect(handle_click)
		generate_sequence(sequence_difficulty[0])
	
func start_game():
	play_sequence()

func generate_sequence(sequence_size):
	for i in range (sequence_size):
		var nova_cor = randi_range(0,5)
		correct_sequence.append(nova_cor)
	print(correct_sequence)

func play_sequence ():
	var simon_buttons = [light_blue, red, pink, yellow, brown, dark_blue]
	#Running Animation
	for id_color in correct_sequence:
		#Await other animations end
		await get_tree().create_timer(0.5).timeout
		#Await actual animation end
		await simon_buttons[id_color].animate_button("animation")
	#Enabling buttons 
	for simon_button in simon_buttons:
		simon_button._enable_button()

func handle_click (botao_clicado: int):
	#Wait for animation end
	await get_tree().create_timer(0.7).timeout
	if botao_clicado == correct_sequence[player_sequence_size]:
		player_sequence_size += 1
		if player_sequence_size == correct_sequence.size():
			handle_win()
	else:
		handle_loss()
		
func handle_all_buttons(was_win: bool):
	var simon_buttons = [light_blue, red, pink, yellow, brown, dark_blue]
	if (was_win):
		for simon_button in simon_buttons:
			simon_button.animate_button("animation")
			simon_button._disable_button()
		simon_start_button._level_win()
	else:
		for simon_button in simon_buttons:
			simon_button._disable_button()
		simon_start_button._level_lose()

func instantiate_prize():
	var x_pos = 208
	var y_pos = 114
	var prize = PRIZE_ITEM.instantiate()
	prize.position = Vector2(x_pos, y_pos)
	get_parent().add_child(prize)
	
func handle_win ():
	if (actual_difficulty == 2):
		handle_all_buttons(true)
		GameManager.simon_completed = true
		instantiate_prize()
	else:
		handle_all_buttons(true)
		#Await Animation End
		await get_tree().create_timer(1).timeout
		actual_difficulty += 1
		correct_sequence.clear()
		player_sequence_size = 0
		generate_sequence(sequence_difficulty[actual_difficulty])
		play_sequence()

func handle_loss ():
	player_sequence_size = 0
	handle_all_buttons(false)
