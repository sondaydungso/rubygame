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
		@velocity_x = 2
		@velocity_y = 2
		@visible = 0
		@hammer_image = Gosu::Image.new('hammer.png')
		@hit = 0 
		@score = 0
		@font = Gosu::Font.new(30)
		@time_left = Gosu.milliseconds / 1000
		@play = true
		#@space = 0
		@time = 0

	end
	def update()
		if @play
			@x += @velocity_x
			@y += @velocity_y
			@velocity_x *= -1 if @x - @width / 2 > 800 || @x - @width < 0
			@velocity_y *= -1 if @y - @height /2 > 600 || @y - @height < 0
			@visible -= 1
			@visible = 30 if @visible < -10 and rand 0.3
			@time_left = Gosu.milliseconds / 1000
			@play = false if @time_left > 1
			#@play = true if @space == 1
		end



	end
	def draw()
		if @visible >0
			@image.draw(@x - @width / 2, @y - @height / 2, 1 )
		end
		@hammer_image.draw(mouse_x - 40, mouse_y - 10, 1)
		if @hit == 0
			c = Gosu::Color::NONE
		elsif @hit == 1
			c = Gosu::Color::GREEN
		else @hit == -1
			c = Gosu::Color::RED
		end
		draw_quad(0,0,c,800,0,c,800,600,c,0,600,c)
		@hit = 0
		@font.draw_text(@score.to_s, 700, 100, 0)
		@font.draw_text(@time_left.to_s, 700, 20, 0)
		unless @play
			@font.draw_text('Game over', 300, 300, 0)
			@visible = 20
			@font.draw_text('press space to play again', 230, 350, 0)
			
		end
			
	end
	def button_down(id)
		if @play 
			if (id == Gosu::MsLeft)
				if Gosu.distance(mouse_x, mouse_y, @x, @y) < 50 and @visible >= 0
					@hit = 1
					@score += 5
				else
					@hit = -1
					@score -= 3
				end	
			end
		else (id == Gosu::KbSpace)
			@play = true
			@time = Gosu.milliseconds
			@score = 0
			@visible = -10
			
		
		end


	end

end

Window = WhackaRuby.new
Window.show