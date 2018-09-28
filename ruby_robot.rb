# Manipulate robot
class Robot
  attr_accessor :current_pos, :directions

  def initialize(table_x = 5, table_y = 6)
    @table_x = table_x
    @table_y = table_y
    @directions = %w[WEST NORTH EAST SOUTH]
    p('Place your robot')
    request = gets.chomp
    while request != 'EXIT'
      play(request)
      request = gets.chomp
    end
  end

  def play(str)
    regx_command = /(?<command>^\w+)/.match(str)
    case regx_command[:command]
    when 'PLACE'
      regx_params = /(?<command>^\w+) (?<x_dim>\d+),(?<y_dim>\d+),(?<direction>\w+)/.match(str)
      place(regx_params[:x_dim].to_i, regx_params[:y_dim].to_i, regx_params[:direction])
    when 'MOVE'
      move if @current_pos
    when 'LEFT'
      left if @current_pos
    when 'RIGHT'
      right if current_pos
    when 'REPORT'
      report if @current_pos
    end
  end

  def place(x_dim, y_dim, direction)
    return p('dont place outside a table') if x_dim < 0 || x_dim > @table_x || y_dim < 0 || y_dim > @table_y

    @current_pos = { :x_dim => x_dim, :y_dim => y_dim, :direction => direction }
    p('Robot was placed')
  end

  def left
    @current_pos[:direction] = @directions[@directions.index(@current_pos[:direction]).pred]
  end

  def right
    @current_pos[:direction] = @directions[@directions.index(@current_pos[:direction]).next] || @directions[0]
  end

  def move
    case @current_pos[:direction]
    when 'WEST'
      @current_pos[:x_dim] -= 1 unless @current_pos[:x_dim].zero?
    when 'NORTH'
      @current_pos[:y_dim] += 1 unless @current_pos[:y_dim] == @table_y
    when 'EAST'
      @current_pos[:x_dim] += 1 unless @current_pos[:x_dim] == @table_x
    when 'SOUTH'
      @current_pos[:y_dim] -= 1 unless @current_pos[:y_dim].zero?
    end
  end

  def report
    return  puts('Robot not placed') if @current_pos.nil?

    puts("Output: #{@current_pos[:x_dim]},#{@current_pos[:y_dim]},#{@current_pos[:direction]}")
  end
end
_run = Robot.new(10, 10)
