# frozen_string_literal: true

module TestUtils
  extend self

  def default_font(pdf)
    pdf.font.family.to_sym
  end

  def prepare_document(html)
    Prawn::Document.new.tap do |pdf|
      pdf.styled_text html
    end
  end
end
