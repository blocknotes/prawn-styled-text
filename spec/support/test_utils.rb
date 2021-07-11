# frozen_string_literal: true

module TestUtils
  extend self

  def default_font
    ::Prawn::Document.new.font
  end

  def default_font_family
    default_font.family.to_sym
  end

  def font_ascender(font_family: 'Helvetica', font_size: 12)
    ascender = Prawn::Document.new.font(font_family, size: font_size).ascender
    [ascender, TestUtils.default_font.ascender].max
  end

  def styled_text_document(html)
    ::Prawn::Document.new.tap do |pdf|
      yield(pdf) if block_given?
      ::HtmlHandler.new(pdf).process(html)
    end
  end
end
