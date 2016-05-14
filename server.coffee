
express = require("express")
app = express()
http = require('http').Server(app)
io = require("socket.io")(http)

app.use(express.static('.'))

app.get '/', (req, res)->
	res.sendFile "#{__dirname}/index.html"

port = process.env.PORT ? 3000
ip = process.env.IP ? "localhost"
http.listen port, ip, ->
	console.log "listening on #{ip}:#{port}"

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
		# io.emit "bubbles", bubbles
		io.emit "bubble", bubble

