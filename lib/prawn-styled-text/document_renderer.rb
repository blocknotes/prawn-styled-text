# frozen_string_literal: true

class DocumentRenderer
  BLOCK_ELEMENTS = %i[br div h1 h2 h3 h4 h5 h6 li p ul].freeze

  def initialize(pdf)
    @buffer = []
    @context = []
    @global = {}
    @options = {}
    @pdf = pdf
    @recent_newline = false
  end

  def check_newline(tag)
    return if @recent_newline || !(@recent_newline = BLOCK_ELEMENTS.include?(tag))

    @buffer << { text: "\n" }
    render_block
  end

  def context_push(tag, attrs)
    check_newline(tag)
    options = {}
    options[:link] = attrs['href'] if attrs['href']
    return render_image(attrs) if tag == :img && attrs['src']

    styles = StyleAttributes.new(@pdf, tag, attrs['style'])
    @context.push(tag: tag, options: options, styles: styles)
    special_tags(tag)
    return unless styles.padding[:padding_top]

    render_block
    @pdf.move_down(styles.padding[:padding_top])
  end

  def context_pop
    element = @context.pop
    check_newline(element[:tag]) if element
  end

  def evaluate_styles(styles)
    styles.scan(/\s*([^{\s]+)\s*{([^}]+)/).each do |sel, style|
      @global[sel] = StyleAttributes.parse(style)
    end
  end

  def output_buffer
    @pdf.formatted_text(@buffer, @options)
  end

  def prepare_content(content) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @recent_newline = false

    # Prepare styles
    styles = {}
    extra_styles = {}
    @context.each do |element|
      styles.merge!(element[:styles].styles)
      extra_styles.merge!(element[:styles].extra_styles)
    end
    extra_styles.each { |opt, val| @options[opt] ||= val }
    # Prepare options
    if @context.last
      @context.last[:styles].options.each { |opt, val| @options[opt] ||= val }
      styles.merge!(@context.last[:options])
    end

    @options.merge!(@context[-2][:styles].padding) if @context[-2]

    @buffer << styles.merge(text: content)
  end

  def render_image(attrs) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
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

  def render_block # rubocop:disable Metrics/PerceivedComplexity
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

  def special_tags(tag)
    case tag
    when :hr
      render_block
      @pdf.stroke_horizontal_rule
    end
  end

  alias_method :flush, :render_block
end
