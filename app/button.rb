class Button
  def initialize(x, y, width, height, background_color, text, text_size, text_color, code_to_execute)
    @x = x
    @y = y
    @w = width
    @h = height

    @background_color = background_color
    @text = text
    @text_size = text_size
    @text_color = text_color
    @code_to_execute = code_to_execute
  end

  def render_and_calculate(args)
    render(args)
    calculate(args)
  end

  def render(args)
    args.outputs.solids << [@x, @y, @w, @h, @background_color[0], @background_color[1], @background_color[2]]

    _, label_height = args.gtk.calcstringbox(@text, @text_size)
    args.outputs.labels << [@x + @w / 2, @y + @h / 2 + label_height / 2, @text, @text_size, 1]
  end

  def calculate(args)
    mouse_clicked = args.inputs.mouse.click
    if mouse_clicked != nil && args.inputs.mouse.click.inside_rect?([@x, @y, @w, @h])
      @code_to_execute.call(args)
    end
  end
end
