class Card
attr_reader :value
attr_accessor :face

  def initialize(value, face = false)
    @value = value
    @face = face
  end

  def display
    puts value if self.face
  end

  def reveal
    self.face = true
  end

  def hide
    self.face = false
  end

  def ==(other_card)
    self.value == other_card.value
  end

end
