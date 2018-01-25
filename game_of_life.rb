require 'shoes'


class Life

  attr_accessor :x, :y, :population, :generation, :desk, :new_desk

  def initialize(x, y)
    @x = x
    @y = y
    @desk = []
    @generation = 0
  end

  def fill_desk
    (0...y).each do |i|
      @desk << []
      (0...x).each do |j|
        @desk[i] << rand(2)
      end
    end
    set_population
    self
  end

  def turn!
    fill_new_desk
    @desk = @new_desk
    @generation += 1
    set_population
    self
  end

  def fill_new_desk
    @new_desk = []
    (0...y).each do |i|
      @new_desk << []
      (0...x).each do |j|
        @new_desk[i] << generate_cell(i,j)
      end
    end
  end

  def generate_cell(i, j)
    if @desk[i][j] == 0
      cell_will_born?(i,j) ? 1 : 0
    else
      cell_will_die?(i,j) ? 0 : 1
    end
  end

  def cell_will_born?(i,j)
    count_neighbours(i,j) == 3
  end

  def cell_will_die?(i,j)
    ![2,3].include?(count_neighbours(i,j))
  end

  def count_neighbours(i,j)
    count = 0
    i_indexes = [i-1, i, i+1].delete_if{|index| index<0 || index>=y}
    j_indexes = [j-1, j, j+1].delete_if{|index| index<0 || index>=x}
    i_indexes.each do |i_index|
      j_indexes.each do |j_index|
        count += desk[i_index][j_index] unless (i_index == i && j_index == j)
      end
    end
    count
  end

  def set_population
    @population = @desk.flatten.inject(&:+)
  end

  def print_desk
    desk.each do |line|
      puts line.inspect
    end
    nil
  end
end

Shoes.app(title: "Game of Life", width: 420, height: 500) do

  def new_game
    @game = Life.new(30,30).fill_desk
  end

  def draw_desk
    stack {
      @game.desk.each_with_index do |line, line_index|
          line.each_with_index do |cell, cell_index|
            if cell == 0
              fill white
            else
              fill black
            end
            rect(left: cell_index * 14,
                 top: line_index * 14,
                 width: 14)
          end
      end
    }
  end

  def new_turn
    @desk_slot.clear if @desk_slot
    @game.turn!
    @desk_slot = draw_desk
    @info.replace "Pop: #{@game.population} | Gen: #{@game.generation}"
  end


  def redraw_desk
    @desk_slot.clear if @desk_slot
    new_game
    @desk_slot = draw_desk
  end

  def start_game
    @status = true
    animate(3) do
      new_turn if @status
    end
  end

  def stop_game
    @status = false
  end

  flow(margin: 10) {
    @redraw = button "Redraw"
    @start = button "Start"
    @stop = button "Stop"
    # @stop = button "Stop"
    @info = para ""
    @redraw.click { redraw_desk }
    @start.click { start_game }
    @stop.click { stop_game }
  }

  redraw_desk


end


