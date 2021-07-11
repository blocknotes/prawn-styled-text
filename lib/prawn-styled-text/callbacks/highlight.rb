# frozen_string_literal: true

module PrawnStyledText
  module Callbacks
    class Highlight
      def initialize(pdf, color)
        @pdf = pdf
        @color = color
      end

      def conf=(value)
        @color = value[:background]
      end

      def render_behind(fragment)
        original_color = @pdf.fill_color
        @pdf.fill_color = @color
        @pdf.fill_rectangle(fragment.top_left, fragment.width, fragment.height)
        @pdf.fill_color = original_color
      end
    end
  end
end
