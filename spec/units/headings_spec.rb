# frozen_string_literal: true

RSpec.describe 'Headings' do
  def base_position(pdf, font_size, margin_top: 16)
    font = Prawn::Document.new.font('Helvetica', size: font_size)
    [pdf.page.margins[:left], pdf.y - font.ascender - margin_top]
  end

  let(:pdf_doc) { TestUtils.styled_text_document(html) }

  context 'with some content in an element h1' do
    let(:html) { '<h1>Some content in a element h1</h1>' }

    let(:expected_content) { ['Some content in a element h1'] }
    let(:expected_positions) do
      y = pdf_doc.y - TestUtils.font_ascender(font_size: StyleAttributes::SIZES[:h1]) - StyleAttributes::MARGINS[:h1]
      [[pdf_doc.page.margins[:left], y.round(3)]]
    end
    let(:expected_font_settings) { [{ name: TestUtils.default_font_family, size: StyleAttributes::SIZES[:h1] }] }

    include_examples 'checks contents, positions and font settings'
  end

  context 'with some content in an element h2' do
    let(:html) { '<h2>Some content in a element h2</h2>' }

    let(:expected_content) { ['Some content in a element h2'] }
    let(:expected_positions) do
      y = pdf_doc.y - TestUtils.font_ascender(font_size: StyleAttributes::SIZES[:h2]) - StyleAttributes::MARGINS[:h2]
      [[pdf_doc.page.margins[:left], y.round(3)]]
    end
    let(:expected_font_settings) { [{ name: TestUtils.default_font_family, size: StyleAttributes::SIZES[:h2] }] }

    include_examples 'checks contents, positions and font settings'
  end

  context 'with some content in an element h3' do
    let(:html) { '<h3>Some content in a element h3</h3>' }

    let(:expected_content) { ['Some content in a element h3'] }
    let(:expected_positions) do
      y = pdf_doc.y - TestUtils.font_ascender(font_size: StyleAttributes::SIZES[:h3]) - StyleAttributes::MARGINS[:h3]
      [[pdf_doc.page.margins[:left], y.round(3)]]
    end
    let(:expected_font_settings) { [{ name: TestUtils.default_font_family, size: StyleAttributes::SIZES[:h3] }] }

    include_examples 'checks contents, positions and font settings'
  end

  context 'with some content in an element h4' do
    let(:html) { '<h4>Some content in a element h4</h4>' }

    let(:expected_content) { ['Some content in a element h4'] }
    let(:expected_positions) do
      y = pdf_doc.y - TestUtils.font_ascender(font_size: StyleAttributes::SIZES[:h4]) - StyleAttributes::MARGINS[:h4]
      [[pdf_doc.page.margins[:left], y.round(3)]]
    end
    let(:expected_font_settings) { [{ name: TestUtils.default_font_family, size: StyleAttributes::SIZES[:h4] }] }

    include_examples 'checks contents, positions and font settings'
  end

  context 'with some content in an element h5' do
    let(:html) { '<h5>Some content in a element h5</h5>' }

    let(:expected_content) { ['Some content in a element h5'] }
    let(:expected_positions) do
      y = pdf_doc.y - TestUtils.font_ascender(font_size: StyleAttributes::SIZES[:h5]) - StyleAttributes::MARGINS[:h5]
      [[pdf_doc.page.margins[:left], y.round(3)]]
    end
    let(:expected_font_settings) { [{ name: TestUtils.default_font_family, size: StyleAttributes::SIZES[:h5] }] }

    include_examples 'checks contents, positions and font settings'
  end

  context 'with some content in an element h6' do
    let(:html) { '<h6>Some content in a element h6</h6>' }

    let(:expected_content) { ['Some content in a element h6'] }
    let(:expected_positions) do
      y = pdf_doc.y - TestUtils.font_ascender(font_size: StyleAttributes::SIZES[:h6]) - StyleAttributes::MARGINS[:h6]
      [[pdf_doc.page.margins[:left], y.round(3)]]
    end
    let(:expected_font_settings) { [{ name: TestUtils.default_font_family, size: StyleAttributes::SIZES[:h6] }] }

    include_examples 'checks contents, positions and font settings'
  end
end
