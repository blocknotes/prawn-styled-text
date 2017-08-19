module PrawnStyledText
  class HighlightCallback
    def initialize( pdf )
      @document = pdf
    end

    def set_color( color )
      @color = color ? color : DEF_BG_MARK
    end

    def render_behind( fragment )
      original_color       = @document.fill_color
      @document.fill_color = @color
      @document.fill_rectangle(fragment.top_left, fragment.width, fragment.height)
      @document.fill_color = original_color
    end
  end

  class StrikeThroughCallback
    def initialize( pdf )
      @document = pdf
    end

    def render_in_front( fragment )
      y = ( fragment.top_left[1] + fragment.bottom_left[1] ) / 2
      @document.stroke do
        @document.line [ fragment.top_left[0], y ], [ fragment.top_right[0], y ]
      end
    end
  end
end
