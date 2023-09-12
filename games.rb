require 'gosu'
class WhackaRuby < Gosu::Window
	def initialize()
		super(800,600)
		self.caption = "Whack A Ruby!"
		@image = Gosu::Image.new('ruby.png')
		@x = 100
		@y = 100
		@width = 50
		@height = 50
		@velocity_x = 5
		@velocity_y = 5
		@visible = 0
	end
	def update()
		@x += @velocity_x
		@y += @velocity_y
		@velocity_x *= -1 if @x - @width / 2 > 800 || @x - @width < 0
		@velocity_y *= -1 if @y - @height /2 > 600 || @y - @height < 0
		@visible -= 1
		@visible = 30 if @visible < -10 and rand 0.3
	end
	def draw()
		if @visible >0
			@image.draw(@x - @width / 2, @y - @height / 2 )
		end
	end
	

end

Window = WhackaRuby.new
Window.show