require 'gosu'
Dir[File.join(File.dirname(__FILE__), 'lib', 'components', '*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), 'lib', 'units', '*.rb')].each { |file| require file }


X_SIZE = 640
Y_SIZE = 480
TILE_SIZE = 60

class Game < Gosu::Window

  attr_accessor :drawable_objects
  attr_accessor :updatable_objects
  attr_accessor :animations
  attr_accessor :units

  def initialize
    super X_SIZE, Y_SIZE, {}
    self.caption = "Process Game"

    self.drawable_objects = []
    self.updatable_objects = []
    self.units = []

    init_background
    init_animations
    init_units
  end

  def init_units
    AttackingUnit.new(100, 100, self)
    AttackingUnit.new(540, 100, self)
    AttackingUnit.new(540, 380, self)
    AttackingUnit.new(100, 380, self)
  end


  def init_background
    background = Background.new
    drawable_objects << background
  end

  def init_animations
    # presented here as template for when I want a spin to happen
    animations = {}
    animations[:spin] = Gosu::Image::load_tiles(
      File.join(File.dirname(__FILE__), 'images', 'spin.png'),
      60,
      60
    )
  end

  def update
    updatable_objects.each { |ob| ob.update }
  end

  def draw
    drawable_objects.each { |ob| ob.draw }
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

end

window = Game.new
window.show
