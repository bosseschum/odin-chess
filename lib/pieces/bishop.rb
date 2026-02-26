# frozen_string_literal: true

class Bishop < Character
  attr_reader :starting_position

  def initialize(color, position)
    super
    @starting_position = position.dup
  end
end
