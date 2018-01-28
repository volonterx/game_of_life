class Сellule
  attr_accessor :value, :generation

  def initialize(raw_value, generation = 1)
    @value = get_value(raw_value)
    @generation = generation
  end

  def color
    case generation
      when 1
        "#FF7F00"
      when 2
        "#FF0000"
      when 3
        "#9400D3"
      when (4..9)
        "#3333FF"
      else
        "#000000"
    end
  end

  def alive?
    value == 1
  end

  def dead?
    value == 0
  end

  def get_value(raw_value)
    case raw_value
      when "random"
        rand(3) == 0 ? 1 : 0
      else
        raw_value
    end
  end
end