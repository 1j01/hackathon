
class @DistanceConstraint
	constructor: (@a, @b, @length)->
	
	step: ->
		dx = @b.x - @a.x
		dy = @b.y - @a.y
		# console.log dx, dy
		dist = Math.sqrt(dx*dx + dy*dy)
		delta_dist = @length - dist
		# @a.fx += dx * delta_dist / dist * 2
		# @a.fy += dy * delta_dist / dist * 2
		# @a.fx += dx * delta_dist * 2
		# @a.fy += dy * delta_dist * 2
		# @a.fx += dx * delta_dist * 2
		# @a.fy += dy * delta_dist * 2
		# @b.fx -= dx * delta_dist * 2
		# @b.fy -= dy * delta_dist * 2
		@a.fx -= dx * delta_dist / 4000
		@a.fy -= dy * delta_dist / 4000
		@b.fx += dx * delta_dist / 4000
		@b.fy += dy * delta_dist / 4000
		# console.log @a.fy, @b.fy
