# frozen_string_literal: true

class DocumentRenderer
  BLOCK_ELEMENTS = %i[br div h1 h2 h3 h4 h5 h6 li p ul].freeze

  def initialize(pdf)
    @buffer = []
    @context = []
    @global = {}
    @last_component = nil
    @options = {}
    @pdf = pdf
  end

  def context_push(tag, attrs)
    return render_image(attrs) if tag == :img && attrs['src']

    add_newline(tag)
    @buffer << { text: ' ' } if !@buffer.empty? && @last_component == :closing

    options = {}
    options[:link] = attrs['href'] if attrs['href']

    styles = StyleAttributes.new(@pdf, tag, attrs['style'])
    styles.styles[:before_content] = '• ' if tag == :li

    if tag == :small
      size = evaluate_value(:size) || 14
      styles.styles[:size] = size * 2 / 3
    end

    @context.push(tag: tag, options: options, styles: styles)
    special_tags(tag, styles)
    return unless styles.padding[:padding_top]

    render_block
    @pdf.move_down(styles.padding[:padding_top])
    @last_component = :opening
  end

  def context_pop(tag)
    @context.pop
    add_newline(tag)
    @last_component = :closing
  end

  def evaluate_styles(styles)
    styles.scan(/\s*([^{\s]+)\s*{([^}]+)/).each do |sel, style|
      @global[sel] = StyleAttributes.parse(style)
    end
  end

  def flush
    render_block
  end

  def prepare_content(content)
    @recent_newline = false

    # Prepare styles
    styles = {}
    extra_styles = {}
    @context.each do |element|
      styles.merge!(element[:styles].styles)
      extra_styles.merge!(element[:styles].extra_styles)
    end
    extra_styles.each { |opt, val| @options[opt] ||= val }

    prefix = ''
    # Prepare options
    if @context.last
      @context.last[:styles].options.each { |opt, val| @options[opt] ||= val }
      styles.merge!(@context.last[:options])
      prefix = styles[:before_content] if styles.include?(:before_content)
    end

    @options.merge!(@context[-2][:styles].padding) if @context[-2]
    @buffer << styles.merge(text: prefix + content.delete("\n").squeeze(' '))

    @last_component = :text_node
  end

  private

  def add_newline(tag)
    return unless BLOCK_ELEMENTS.include?(tag)

    @buffer << { text: "\n" } if @buffer.any?
    render_block
  end

  def evaluate_value(key)
    ret = nil
    @context.each { |tag| ret = tag[:styles].styles[key] if tag[:styles].styles.include?(key) }
    ret
  end

  def output_buffer
    # puts '--- buffer:', @buffer, '--- options:', @options, "\n" unless @buffer.empty?
    @pdf.formatted_text(@buffer, @options)
  end

  def render_image(attrs)
    options = {}
    StyleAttributes.parse(attrs['style'] || '').each do |k, value|
      key = k.downcase.to_sym
      case key
      when :width
        options[key] = StyleAttributes.convert_size(value, @pdf.bounds.width)
      when :height
        options[key] = StyleAttributes.convert_size(value, @pdf.bounds.height)
      end
    end
    if @context.last
      @context.last[:styles].options.each do |key, value|
        opt = key == :align ? :position : key
        @options[opt] ||= value
      end
      options.merge!(@options)
    end
    render_block { @pdf.image(attrs['src'], options) }
  rescue StandardError => e
    puts "render_image error: #{e}"
  end

  def render_block
    @pdf.move_down(@options[:margin_top]) if @options[:margin_top]
    if (left = @options[:margin_left] || @options[:padding_left])
      @pdf.indent(left) do
        block_given? ? yield : output_buffer
      end
    else
      block_given? ? yield : output_buffer
    end
    @pdf.move_down(@options[:margin_bottom]) if @options[:margin_bottom]
    @options = {}
    @buffer.clear
  end

  def special_tags(tag, styles)
    case tag
    when :hr
      render_block
      @pdf.stroke_color(styles.styles[:color]) if styles.styles[:color]
      @pdf.stroke_horizontal_rule
      @pdf.stroke_color(StyleAttributes::DEF_STROKE) if styles.styles[:color]
    end
  end
end
