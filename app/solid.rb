class Solid
  attr_accessor :x, :y, :w, :h, :r, :g, :b, :a, :anchor_x, :anchor_y, :blendmode_enum

  def initialize(args, x, y, w, h, r, g, b)
    @args = args
    @x = x
    @y = y
    @w = w
    @h = h
    @r = r
    @g = g
    @b = b
  end

  def primitive_marker
    :solid
  end

  def calculate(args)
    # do nothing by default
  end

end

