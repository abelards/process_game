require 'gosu'
Dir[File.join(File.dirname(__FILE__), 'common_components', '*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), 'game_components', '*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), 'faction_components', '*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), 'unit_components', '*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), '*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), 'units', '*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), 'buildings', '*.rb')].each { |file| require file }


X_SIZE = 640
Y_SIZE = 480

class Game < Gosu::Window

  include GameComponents::Factions
  include GameComponents::Units
  include GameComponents::DeclareWinner
  include GameComponents::ActionFrames

  attr_accessor :drawable_objects
  attr_accessor :updatable_objects
  attr_accessor :animations
  attr_accessor :active

  def initialize
    super X_SIZE, Y_SIZE, {}
    self.caption = "Process Game"

    self.drawable_objects = []
    self.updatable_objects = []
    self.active = true
    @frame = 0

    init_units
    init_background
    init_animations
    init_delcaration
  end

  def init_delcaration
    @declaration = GameComponents::Declaration.new(
      X_SIZE / 10
    )
    self.drawable_objects << @declaration
    self.updatable_objects << @declaration
  end

  def init_background
    background = Background.new
    drawable_objects << background
  end

  def init_animations
    # presented here as template for when I want a spin to happen
    @animations = {}
    @animations[:spin] = Gosu::Image::load_tiles(
      File.join(File.dirname(__FILE__), '..', 'images', 'spin.png'),
      60,
      60
    )
  end

  def update
    updatable_objects.each { |ob| ob.update }
    check_for_winner
    close_after_time
    @frame += 1
  end

  def draw
    drawable_objects.each { |ob| ob.draw }
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

  def show
    @declaration.show_text('Game Starts', 2000)
    super()
  end

end
