# frozen_string_literal: true

require_relative 'callbacks/highlight'
require_relative 'callbacks/strike_through'

class StyleAttributes
  DEF_STROKE = '000000'
  DEF_HIGHLIGHT = 'ffff00'

  RULES = {
    'background' => { key: :background, type: :color, store: :styles },
    'color' => { key: :color, type: :color, store: :styles },
    'font-family' => { key: :font, type: :font, store: :styles },
    'font-size' => { key: :size, type: :size, store: :styles },
    'font-style' => { key: nil, type: :style, value: :italic, store: :styles },
    'font-weight' => { key: nil, type: :style, value: :bold, store: :styles },
    'letter-spacing' => { key: :character_spacing, type: :float, store: :styles },
    'line-height' => { key: :leading, type: :float, store: :options },
    # margin
    'margin-bottom' => { key: :margin_bottom, type: :size, store: :options },
    'margin-left' => { key: :margin_left, type: :size, store: :extra_styles },
    # 'margin-right' => { key: :margin_right, type: :size, store: :extra_styles },
    'margin-top' => { key: :margin_top, type: :size, store: :options },
    # 'padding-bottom' => { key: :padding_bottom, type: :size, store: :padding },
    'padding-left' => { key: :padding_left, type: :size, store: :padding },
    # 'padding-right' => { key: :padding_right, type: :size, store: :padding },
    'padding-top' => { key: :padding_top, type: :size, store: :padding },
    'text-align' => { key: :align, type: :choice, choices: %i[left center right justify], store: :options },
  }.freeze

  # DEFAULT_SIZE = 14

  SIZES = {
    body: 14,
    h1: 32,
    h2: 24,
    h3: 18.72,
    h4: 14,
    h5: 13.28,
    h6: 10.72
  }.freeze

  MARGINS = {
    h1: 21.44,
    h2: 19.92,
    h3: 18.72,
    h4: 21.28,
    h5: 22.18,
    h6: 24.98
  }.freeze

  def initialize(pdf, tag, style)
    @output = { extra_styles: {}, options: {}, padding: {}, styles: {} }
    evaluate_tag(pdf, tag)
    StyleAttributes.parse(style || '').each do |key, value|
      evaluate_attribute(tag, key.downcase, value)
    end
  end

  def extra_styles
    @output[:extra_styles]
  end

  def options
    @output[:options]
  end

  def padding
    @output[:padding]
  end

  def styles
    @output[:styles]
  end

  private

  def add_style(style)
    @output[:styles][:styles] << style unless (@output[:styles][:styles] ||= []).include?(style)
  end

  def evaluate_attribute(tag, key, value)
    return unless (rule = RULES[key])
    return unless (result = format_value(rule, value))
    return if filter_special_attrs(tag, key, result)

    @output[rule[:store]][rule[:key]] = result
  end

  def evaluate_tag(pdf, tag)
    @output[:styles][:size] = SIZES[tag] if SIZES.include?(tag)
    @output[:padding][:padding_bottom] = @output[:padding][:padding_top] = MARGINS[tag] if MARGINS.include?(tag)

    case tag
    when :b, :strong
      add_style(:bold)
    when :br
      @output[:padding][:padding_top] ||= SIZES[:body] # TODO: replace with line-height?
    when :i, :em
      add_style(:italic)
    when :u, :ins
      add_style(:underline)
    when :mark
      @output[:styles][:callback] = PrawnStyledText::Callbacks::Highlight.new(pdf, DEF_HIGHLIGHT)
    when :del, :s
      @output[:styles][:callback] = PrawnStyledText::Callbacks::StrikeThrough.new(pdf)
    end
  end

  def filter_special_attrs(tag, key, value)
    if tag == :mark && key == 'background' # rubocop:disable Style/GuardClause
      @output[:styles][:callback]&.conf = { background: value }
    end
  end

  def format_value(rule, value)
    case rule[:type]
    when :choice
      StyleAttributes.convert_choices(value, rule[:choices])
    when :color
      StyleAttributes.convert_color(value)
    when :float
      StyleAttributes.convert_float(value)
    when :font
      StyleAttributes.convert_string(value)
    when :int
      StyleAttributes.convert_int(value)
    when :size
      StyleAttributes.convert_size(value)
    when :style
      val = value.downcase.to_sym
      add_style(rule[:value]) if val == rule[:value]
      nil
    end
  end

  class << self
    def parse(style)
      style.scan(/\s*([^:;]+)\s*:\s*([^;]+)\s*/)
    end

    def convert_choices(value, choices)
      val = value.downcase.to_sym
      choices.include?(val) ? val : nil
    end

    def convert_color(value)
      val = value.gsub(/[^a-fA-F0-9]/, '')
      if val.size == 3
        a, b, c = val.chars
        a * 2 + b * 2 + c * 2
      else
        val
      end
    end

    def convert_float(value)
      value.gsub(/[^0-9.]/, '').to_f.round(3)
    end

    def convert_int(value)
      value.gsub(/[^0-9]/, '').to_i
    end

    def convert_size(value, container_size = nil)
      val = value.gsub(/[^0-9.]/, '').to_f # TODO: parse size values
      val *= container_size * 0.01 if container_size && value.include?('%')
      # pdf.bounds.height
      val.round(3)
    end

    def convert_string(value)
      value.gsub(/[^a-zA-Z ]/, '')
    end
  end
end
