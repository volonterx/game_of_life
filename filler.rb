class Filler

  attr_accessor :life, :desk

  def initialize(life)
    @life = life
    @desk = []
  end


  def fill
    case life.content
      when "Random"
        fill_random
      when "Random symmetry"
        fill_symmetry
      when "Empty"
        fill_empty
      when "Small random pattern"
        fill_small_pattern
      when "Big random pattern"
        fill_big_pattern
    end
    @desk
  end

  def fill_random
    (0...life.y).each do |i|
      @desk << []
      (0...life.x).each do |j|
        @desk[i] << random_cell
      end
    end
  end

  def fill_symmetry
    (0...life.y).each do |i|
      @desk << []
      (0...life.x/2).each do |j|
        @desk[i] << random_cell
      end
      @desk[i] += @desk[i].reverse
    end
  end

  def fill_small_pattern
    (0...7).each do |i|
      @desk[i] = pattern_line(7) * (life.x/7)
    end
    (7...life.y).each do |i|
      @desk << @desk[i%7]
    end
  end

  def fill_big_pattern
    (0...14).each do |i|
      @desk[i] = pattern_line(14) * (life.x/14)
    end
    (14...life.y).each do |i|
      @desk << @desk[i%14]
    end
  end

  def pattern_line(lenght)
    line = []
    lenght.times do
      line << random_cell
    end
    line
  end

  def random_cell
    Сellule.new("random")
  end

  def fill_empty
    @desk = Array.new( life.y, Array.new(life.x, Сellule.new(0)) )
  end

end