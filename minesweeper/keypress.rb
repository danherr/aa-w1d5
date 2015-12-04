include Remedy
  joke = Content.new
  joke << "Q: What's the difference between a duck?"
  joke << "A: Purple, because ice cream has no bones!"

  screen = Viewport.new
  screen.draw joke
