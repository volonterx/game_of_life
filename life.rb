
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
    [3].include?(count_neighbours(i,j))
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
        count += desk[i_index][j_index]
      end
    end
    count - desk[i][j]
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