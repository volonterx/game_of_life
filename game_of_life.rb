require 'shoes'
require_relative 'life'

Shoes.app(title: "Game of Life", width: 1000, height: 600) do

  def new_game
    @game = Life.new(100,50).fill_desk
  end

  def draw_desk
    stack {
      background white
      fill black
      stroke white
      @game.desk.each_with_index do |line, line_index|
          line.each_with_index do |cell, cell_index|
            if cell == 1
              rect(left: cell_index * 10,
                   top: line_index * 10,
                   width: 10)
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

  def redraw_desk
    @desk_slot.clear if @desk_slot
    new_game
    @desk_slot = draw_desk
  end

  def start_game
    @status = true
    animate(2) do
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
    @info = para ""
    @redraw.click { redraw_desk }
    @start.click { start_game }
    @stop.click { stop_game }
  }

  redraw_desk


end


