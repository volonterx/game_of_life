
class Life

  attr_accessor :x, :y, :population, :generation, :desk, :new_desk, :content

  def initialize(x, y, content)
    @x = x
    @y = y
    @desk = []
    @generation = 0
    @content = content
  end

  def fill_desk
    @desk = Filler.new(self).fill
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
    old_cell = @desk[i][j]
    if old_cell.value == 0
      if cell_will_born?(i,j)
        cell_value = 1
        cell_generation = 1
      else
        cell_value = 0
        cell_generation = 0
      end
    else
      if cell_will_die?(i,j)
        cell_value = 0
        cell_generation = 0
      else
        cell_value = 1
        cell_generation = old_cell.generation + 1
      end
    end
    Сellule.new(cell_value, cell_generation)
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
        count += desk[i_index][j_index].value
      end
    end
    count - desk[i][j].value
  end

  def set_population
    @population = @desk.flatten.inject(0){|sum, cell| sum += cell.value}
  end

  def print_desk
    desk.each do |line|
      puts " "
      line.each do |cell|
        print [cell.value, cell.generation]
      end
    end
    nil
  end
end