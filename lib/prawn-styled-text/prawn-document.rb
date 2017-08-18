require 'prawn'

Prawn::Document.class_eval do
  def styled_text( data )
    parts = []
    text_options = {}
    extra_options = { margin_left: 0 }
    oga = Oga.parse_html data
    PrawnStyledText::traverse oga.children do |type, text, data|
      context = if type == :text_node
          PrawnStyledText::text_node( self, data )
        elsif type == :opening_tag
          PrawnStyledText::opening_tag( self, data )
        else
          PrawnStyledText::closing_tag( self, data )
        end
      if context[:flush] && parts.any? # flush current parts
        parts[0][:text] = parts[0][:text].lstrip
        parts.shift if parts[0][:text].empty?
        if parts.any?
          parts[-1][:text] = parts[-1][:text].rstrip
          parts.pop if parts[-1][:text].empty?
        end
        # p '###', parts
        if parts.any?
          parts[0][:text] = extra_options[:pre] + parts[0][:text] if extra_options[:pre]
          self.indent( extra_options[:margin_left] ) do
            self.formatted_text parts, text_options
          end
        end
        parts = []
        text_options = {}
        extra_options = { margin_left: 0 }
      end
      options = context[:options]
      if type == :text_node
        # prepare options
        text_options[:align] = options[:'text-align'].to_sym if options[:'text-align']
        margin_top = options.delete( :'margin-top' ).to_i
        self.move_down( margin_top ) if margin_top > 0
        margin_left = options.delete( :'margin-left' ).to_i
        extra_options[:margin_left] = margin_left if margin_left > 0
        if !text_options[:leading] && ( leading = options.delete( :'line-height' ).to_i ) > 0
          text_options[:leading] = leading
        end
        text_options[:mode] = options[:'mode'].to_sym if options[:'mode']
        extra_options[:pre] = context[:pre] if context[:pre]
        parts << { text: text }.merge( options ) # push the data
      elsif type == :closing_tag
        self.formatted_text( context[:text] ) if context[:text]
        if context[:tag] == :hr
          self.dash( options[:dash].to_i ) if options[:dash]
          if options[:color]
            last_stroke_color = self.stroke_color
            self.stroke_color( options[:color] )
          end
          self.stroke_horizontal_rule
          self.stroke_color( last_stroke_color ) if options[:color]
          self.undash if options[:dash]
        elsif context[:tag] == :img && context[:src]
          image_options = {}
          image_options[:scale] = options[:'image-scale'].to_f if options[:'image-scale']
          if options[:'image-at']
            xy = options[:'image-at'].split( ',' ).map &:to_i
            image_options[:at] = xy if xy.count == 2
            # p image_options[:at]
          end
          if options[:'image-position']
            pos = options[:'image-position'].to_i
            image_options[:position] = pos > 0 ? pos : options[:'image-position']
          end
          if options[:'width']
            w = options[:'width'].to_i
            if w > 0
              image_options[:width] = options[:'width'].include?( '%' ) ? ( w * self.bounds.width * 0.01 ) : w
            end
          end
          image_options[:height] = options[:'height'].to_i if options[:'height']
          self.image context[:src], image_options
        end
      end
    end
    self.formatted_text parts, text_options
  end
end
