
# host = if location.hostname is "localhost" then "localhost:1326" else "https://vczmpwyabn.localtunnel.me"
# host = if location.hostname is "localhost" then "localhost:1326" else "tcp://0.tcp.ngrok.io:12812"
#host = if location.hostname is "localhost" then "localhost:1326" else "http://25736b14.ngrok.io"

# host = "#{location.hostname}:1326"
#console.log host
# socket = io.connect(host)
socket = io()

socket.on "bubble", (bubble)->
	console.log "BUBBLBBBLB", bubble

input = document.createElement "input"
document.body.appendChild input

input.onkeydown = (e)->
	if e.keyCode is 13
		text = input.value
		socket.emit "bubble", text
		input.value = ""

