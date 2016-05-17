
class @Bubble
	constructor: ({@text, @from, @id, respond})->
		@element = document.createElement "div"
		@text_el = document.createElement "span"
		@nick_el = document.createElement "span"
		@respond_button = document.createElement "button"
		@nick_el.textContent = "#{@from or "anonymous"}: "
		@text_el.textContent = @text
		@respond_button.textContent = "+"
		@respond_button.classList.add "respond"
		@element.classList.add "bubble"
		@element.appendChild @nick_el
		@element.appendChild @text_el
		@element.appendChild @respond_button
		@x = 0
		@y = 0
		@fx = 0
		@fy = 0
		@vx = 0
		@vy = 0
		# @vy += Math.random()/20
		@respond_button.addEventListener "click", (e)=>
			respond(@id)
	step: ->
		rect = @element.getBoundingClientRect()
		@width = rect.width
		@height = rect.height
		@x += @vx
		@y += @vy
		@vx *= 0.9
		@vy *= 0.9
		@vy += 0.1
		@vx += (Math.random()-1/2)/5
		# @vy += Math.random()/2
		@element.style.position = "absolute"
		@element.style.left = "#{innerWidth/2 + @x - @width/2}px"
		@element.style.top = "#{@y}px"
