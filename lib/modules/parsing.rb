# frozen_string_literal: true

# Module for parsing input and output to chess notation.
module Parsing
  def to_notation(position)
    col = ('a'.ord + position[1]).chr
    row = 8 - position[0]
    "#{col.upcase}#{row}"
  end

  def parse_input(input)
    row = 8 - input.last.to_i
    col = input.first.downcase.ord - 'a'.ord
    [row, col]
  end
end
