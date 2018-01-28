require 'shoes'
require_relative 'cellule'
require_relative 'filler'
require_relative 'life'

Shoes.app(title: "Game of Life", width: 1121, height: 640) do

  def new_game(content)
    @game = Life.new(112, 56, content).fill_desk
  end

  def draw_desk
    stack(margin: [1,0,0,0]) {
      background white
      nostroke #white
      @game.desk.each_with_index do |line, line_index|
          line.each_with_index do |cell, cell_index|
            if cell.alive?
              fill cell.color
              rect(left: cell_index * 10,
                   top: line_index * 10,
                   width: 9)
            end
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

  def redraw_desk(content)
    @active = false
    @desk_slot.clear if @desk_slot
    new_game(content)
    @desk_slot = draw_desk
  end

  def start_game
    @active = true
    animate(3) do
      new_turn if @active
    end
  end

  def stop_game
    @active = false
  end

  flow(margin: 10) {
    list_box items: ["Empty", "Random", "Random symmetry", "Small random pattern", "Big random pattern"],
      width: 200, choose: "Empty" do |list|
      @content = list.text
    end
    @fill = button "Fill"
    @start = button "Start"
    @stop = button "Stop"
    @info = para(margin: [0, 8, 0, 0]) {""}
    @fill.click { redraw_desk(@content) }
    @start.click { start_game }
    @stop.click { stop_game }
  }

  redraw_desk("Empty")


end


