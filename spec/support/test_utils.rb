# frozen_string_literal: true

module TestUtils
  extend self

  def default_font
    Prawn::Document.new.font
  end

  def default_font_family
    default_font.family.to_sym
  end

  def styled_text_document(html)
    Prawn::Document.new.tap do |pdf|
      pdf.styled_text html
    end
  end
end
