# frozen_string_literal: true

class StyleAttributes
  RULES = {
    'color' => { key: :color, type: :color, store: :styles },
    'font-family' => { key: :font, type: :font, store: :styles },
    'font-size' => { key: :size, type: :size, store: :styles },
    'font-style' => { key: nil, type: :style, value: :italic, store: :styles },
    'font-weight' => { key: nil, type: :style, value: :bold, store: :styles },
    'letter-spacing' => { key: :character_spacing, type: :float, store: :styles },
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
    h1: 36,
    h2: 30,
    h3: 24,
    h4: 18,
    h5: 14,
    h6: 12
  }.freeze

  def initialize(pdf, tag, style)
    @pdf = pdf
    @output = { extra_styles: {}, options: {}, padding: {}, styles: {} }
    evaluate_tag(tag)
    StyleAttributes.parse(style || '').each do |key, value|
      evaluate_attribute(key.downcase, value.strip)
    end
  end

  def add_style(style)
    @output[:styles][:styles] << style unless (@output[:styles][:styles] ||= []).include?(style)
  end

  def evaluate_attribute(key, value)
    return if !(rule = RULES[key])
    return unless (result = format_value(rule, value))

    @output[rule[:store]][rule[:key]] = result
  end

  def evaluate_tag(tag)
    @output[:styles][:size] = SIZES[tag] if SIZES.include?(tag)
    case tag
    when :b, :strong
      add_style(:bold)
    when :i, :em
      add_style(:italic)
    end
  end

  def format_value(rule, value) # rubocop:disable Metrics/MethodLength
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
      StyleAttributes.convert_size(value, @pdf)
    when :style
      val = value.downcase.to_sym
      add_style(rule[:value]) if val == rule[:value]
      nil
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
        a, b, c = val.split('')
        a * 2 + b * 2 + c * 2
      else
        val
      end
    end

    def convert_float(value)
      value.gsub(/[^0-9\.]/, '').to_f
    end

    def convert_int(value)
      value.gsub(/[^0-9]/, '').to_i
    end

    def convert_size(value, container_size = nil)
      val = value.gsub(/[^0-9\.]/, '').to_f # TODO: parse size values
      val *= container_size * 0.01 if container_size && value.include?('%')
      # pdf.bounds.height
      val
    end

    def convert_string(value)
      value.gsub(/[^a-zA-Z ]/, '')
    end
  end
end
