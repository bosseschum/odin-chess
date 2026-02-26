# frozen_string_literal: true

class Knight
  attr_reader :starting_position

  def initialize(color, position)
    super
    @starting_position = position.dup
  end
end
