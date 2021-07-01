# frozen_string_literal: true

RSpec.describe 'Headings' do
  def base_position(pdf, font_size, margin_top: 16)
    font = Prawn::Document.new.font('Helvetica', size: font_size)
    [pdf.page.margins[:left], pdf.y - font.ascender - margin_top]
  end

  def font_ascender(font_size:)
    Prawn::Document.new.font('Helvetica', size: font_size).ascender
  end

  let(:pdf_doc) { TestUtils.styled_text_document(html) }

  context 'with some content in an element h1' do
    let(:html) { '<h1>Some content in a element h1</h1>' }

    let(:expected_content) { ['Some content in a element h1'] }
    let(:expected_x) { pdf_doc.page.margins[:left] }
    let(:expected_y) { pdf_doc.y - font_ascender(font_size: 32) - PrawnStyledText::DEF_HEADING_T }
    let(:expected_font_family) { TestUtils.default_font_family }
    let(:expected_font_size) { 32 }

    include_examples 'checks contents, positions and font settings'
  end

  context 'with some content in an element h2' do
    let(:html) { '<h2>Some content in a element h2</h2>' }

    let(:expected_content) { ['Some content in a element h2'] }
    let(:expected_x) { pdf_doc.page.margins[:left] }
    let(:expected_y) { pdf_doc.y - font_ascender(font_size: 24) - PrawnStyledText::DEF_HEADING_T }
    let(:expected_font_family) { TestUtils.default_font_family }
    let(:expected_font_size) { 24 }

    include_examples 'checks contents, positions and font settings'
  end

  context 'with some content in an element h3' do
    let(:html) { '<h3>Some content in a element h3</h3>' }

    let(:expected_content) { ['Some content in a element h3'] }
    let(:expected_x) { pdf_doc.page.margins[:left] }
    let(:expected_y) { pdf_doc.y - font_ascender(font_size: 20) - PrawnStyledText::DEF_HEADING_T }
    let(:expected_font_family) { TestUtils.default_font_family }
    let(:expected_font_size) { 20 }

    include_examples 'checks contents, positions and font settings'
  end

  context 'with some content in an element h4' do
    let(:html) { '<h4>Some content in a element h4</h4>' }

    let(:expected_content) { ['Some content in a element h4'] }
    let(:expected_x) { pdf_doc.page.margins[:left] }
    let(:expected_y) { pdf_doc.y - font_ascender(font_size: 16) - PrawnStyledText::DEF_HEADING_T }
    let(:expected_font_family) { TestUtils.default_font_family }
    let(:expected_font_size) { 16 }

    include_examples 'checks contents, positions and font settings'
  end

  context 'with some content in an element h5' do
    let(:html) { '<h5>Some content in a element h5</h5>' }

    let(:expected_content) { ['Some content in a element h5'] }
    let(:expected_x) { pdf_doc.page.margins[:left] }
    let(:expected_y) { pdf_doc.y - font_ascender(font_size: 14) - PrawnStyledText::DEF_HEADING_T }
    let(:expected_font_family) { TestUtils.default_font_family }
    let(:expected_font_size) { 14 }

    include_examples 'checks contents, positions and font settings'
  end

  context 'with some content in an element h6' do
    let(:html) { '<h6>Some content in a element h6</h6>' }

    let(:expected_content) { ['Some content in a element h6'] }
    let(:expected_x) { pdf_doc.page.margins[:left] }
    let(:expected_y) { pdf_doc.y - font_ascender(font_size: 13) - PrawnStyledText::DEF_HEADING_T }
    let(:expected_font_family) { TestUtils.default_font_family }
    let(:expected_font_size) { 13 }

    include_examples 'checks contents, positions and font settings'
  end
end
