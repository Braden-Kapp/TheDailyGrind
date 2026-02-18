extends CharacterBody2D
const path ='res://scenes/droplets.tscn'
var droplet_scene := preload(path) as PackedScene

const SPEED = 300.0
var parent_node
var counter
var gameComplete = false

#signal finished

func _ready() -> void:
	parent_node = get_parent()
	#var timer = parent_node.get_node("Timer")
	#timer.start()  
	spawn_droplets()
	#print_tree()
	counter = 0

func _physics_process(delta: float) -> void:

	var direction := Input.get_axis("A", "D")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
func spawn_droplets():
	var droplet_instanceB = droplet_scene.instantiate()
	var droplet_instanceG = droplet_scene.instantiate()
	var droplet_instanceO = droplet_scene.instantiate()
	
	#edit sprites
	droplet_instanceO.get_node("Body/BSprite").visible = false
	
	droplet_instanceG.get_node("Body/BSprite").visible = false
	droplet_instanceG.get_node("Body/OSprite").visible = false
	#sets position
	droplet_instanceB.position = Vector2(242,124)
	droplet_instanceG.position = Vector2(132,124)
	droplet_instanceO.position = Vector2(352,124)
	#Had to add call deferred to help Parent busy issue
	#parent_node.print_tree()
	parent_node.add_child.call_deferred(droplet_instanceG)
	await get_tree().create_timer(1).timeout
	parent_node.add_child.call_deferred(droplet_instanceO)
	await get_tree().create_timer(1).timeout
	parent_node.add_child.call_deferred(droplet_instanceB)

func _process(delta: float) -> void:
	if counter == 3:
		parent_node.end_game()
		
#func end_game():
#	emit_signal("finished")
	
func _on_area_2d_body_entered(body: Node) -> void:
	if body is RigidBody2D:
		counter += 1
		print(counter)
		body.get_parent().queue_free() 


func _on_timer_timeout() -> void:
	parent_node.failed_game()
