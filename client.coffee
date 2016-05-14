
socket = io()

nick = ""

log = document.createElement "div"
document.body.appendChild log
log.classList.add "log"

displayBubble = ({text, from})->
	console.log "recieved bubble", {text, from}
	bubble = document.createElement "div"
	log.appendChild bubble
	bubble.title = "from #{from or "anonymous"}"
	bubble.textContent = text
	bubble.classList.add "bubble"
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
