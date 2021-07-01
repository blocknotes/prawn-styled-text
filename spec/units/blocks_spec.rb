# frozen_string_literal: true

RSpec.describe 'Blocks' do
  let(:pdf_doc) { TestUtils.styled_text_document(html) }

  context 'with some content in an element div' do
    let(:html) { '<div>Some content in a element div</div>' }

    let(:expected_content) { ['Some content in a element div'] }
    let(:expected_x) { pdf_doc.page.margins[:left] }
    let(:expected_y) { pdf_doc.y - TestUtils.default_font.ascender }
    let(:expected_font_family) { TestUtils.default_font_family }
    let(:expected_font_size) { pdf_doc.font_size }

    include_examples 'checks contents, positions and font settings'
  end

  context 'with some content in an element p' do
    let(:html) { '<p>Some content in a element p</p>' }

    let(:expected_content) { ['Some content in a element p'] }
    let(:expected_x) { pdf_doc.page.margins[:left] }
    let(:expected_y) { pdf_doc.y - TestUtils.default_font.ascender }
    let(:expected_font_family) { TestUtils.default_font_family }
    let(:expected_font_size) { pdf_doc.font_size }

    include_examples 'checks contents, positions and font settings'
  end
end
