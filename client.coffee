
socket = io()

nick = "nick"
bubbles = []
bubbles_by_id = {}
constraints = []

log = document.createElement "div"
document.body.appendChild log
log.classList.add "log"

respond = (to_id)->
	bubble = new Bubble({text: "", from: nick, parent: to_id})
	bubble.text_el.setAttribute("contenteditable", "true")
	bubbles.push bubble
	constraints.push(new DistanceConstraint(
		bubble
		bubbles_by_id[to_id]
		40
	))
	log.appendChild(bubble.element)

displayBubble = ({text, from, id})->
	console.log "recieved bubble", {text, from}
	bubble = new Bubble({text, from, respond})
	bubbles_by_id[id] = bubble
	bubbles.push bubble
	if bubbles.length >= 2
		constraints.push(new DistanceConstraint(
			bubbles[bubbles.length - 1]
			bubbles[bubbles.length - 2]
			40
		))
	else
		constraints.push(new DistanceConstraint(
			bubble
			{x: 0, y: 0}
			40
		))
		
	log.appendChild bubble.element
	log.scrollTop = log.scrollHeight

socket.on "bubbles", (bubbles)->
	displayBubble(bubble) for bubble in bubbles

socket.on "bubble", (bubble)->
	displayBubble(bubble)

input_area = document.createElement "div"
document.body.appendChild input_area
input_area.classList.add "input-area"

nick_input = document.createElement "input"
input_area.appendChild nick_input
nick_input.classList.add "nick"
nick_input.placeholder = "Nickname"

input = document.createElement "input"
input_area.appendChild input
input.classList.add "message"

try
	if localStorage.nick
		nick = localStorage.nick
		nick_input.value = nick
		socket.emit "nick", nick

input.onkeydown = (e)->
	if e.keyCode is 13
		text = input.value
		socket.emit "bubble", {text, from: nick}
		input.value = ""

nick_input.onchange = (e)->
	nick = nick_input.value
	socket.emit "nick", nick
	localStorage.nick = nick

@animate = ->
	requestAnimationFrame animate
	for bubble in bubbles
		bubble.fx = 0
		bubble.fy = 0
	for constraint in constraints
		constraint.step()
	for bubble in bubbles
		bubble.vx += bubble.fx
		bubble.vy += bubble.fy
		bubble.step()

