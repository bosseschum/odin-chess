# frozen_string_literal: true

# Module to share movement patterns across chess pieces.
module Movement
  def slide_diagonally
    moves = []

    x, y = @position
    until x == 7 || y == 7
      moves << [x + 1, y + 1]
      x += 1
      y += 1
    end

    x, y = @position
    until x.zero? || y.zero?
      moves << [x - 1, y - 1]
      x -= 1
      y -= 1
    end

    x, y = @position
    until x.zero? || y == 7
      moves << [x - 1, y + 1]
      x -= 1
      y += 1
    end

    x, y = @position
    until x == 7 || y.zero?
      moves << [x + 1, y - 1]
      x += 1
      y -= 1
    end
    moves
  end

  def slide
    moves = []

    x, y = @position
    moves << [x + 1, y] && x += 1 until x == 7
    x, y = @position
    moves << [x, y + 1] && y += 1 until y == 7
    x, y = @position
    moves << [x - 1, y] && x -= 1 until x.zero?
    x, y = @position
    moves << [x, y - 1] && y -= 1 until y.zero?
    moves
  end
end
