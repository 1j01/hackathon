
express = require("express")
app = express()
io = require("socket.io")(1326)
http = require('http').Server(app)

app.use(express.static('.'))

app.get '/', (req, res)->
	res.sendFile "#{__dirname}/index.html"

http.listen 3000, ->
	console.log 'listening on *:3000'

bubbles = []
clients = []

io.on "connection", (client)->
	clients.push client
	client.emit "bubbles", bubbles
	client.on "nick", (nick)->
		client.nick = nick
		io.emit "client-nicks", (client.nick for client in clients)
	client.on "bubble", (bubble)->
		console.log "recieved bubble", bubble
		bubbles.push bubble
		io.emit "bubbles", bubbles
		io.emit "bubble", bubble

