# frozen_string_literal: true

class Pawn < Character
  attr_reader :starting_position
  attr_accessor :en_passantable

  def initialize(color, position)
    super
    @starting_position = position.dup
    @en_passantable = false
    @can_double_step = true
  end
end
