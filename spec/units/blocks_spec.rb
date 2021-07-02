# frozen_string_literal: true

RSpec.describe 'Blocks' do
  let(:pdf_doc) { TestUtils.styled_text_document(html) }

  context 'with some content in an element div' do
    let(:html) { '<div>Some content in a element div</div>' }

    let(:expected_content) { ['Some content in a element div'] }
    let(:expected_positions) do
      [[pdf_doc.page.margins[:left], pdf_doc.y - TestUtils.default_font.ascender]]
    end
    let(:expected_font_settings) { [{ name: TestUtils.default_font_family, size: 12 }] }

    include_examples 'checks contents, positions and font settings'
  end

  context 'with some content in an element p' do
    let(:html) { '<p>Some content in a element p</p>' }

    let(:expected_content) { ['Some content in a element p'] }
    let(:expected_positions) do
      [[pdf_doc.page.margins[:left], pdf_doc.y - TestUtils.default_font.ascender]]
    end
    let(:expected_font_settings) { [{ name: TestUtils.default_font_family, size: 12 }] }

    include_examples 'checks contents, positions and font settings'
  end
end
