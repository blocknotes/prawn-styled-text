# frozen_string_literal: true

RSpec.describe 'Misc' do
  let(:pdf_doc) { TestUtils.styled_text_document(html) }

  shared_examples 'a specific element with some test content' do
    let(:html) { [expected_content[0], test_content, expected_content[2]].join }

    let(:expected_content) { ['Some ', 'test', ' content'] }
    let(:expected_positions) do
      x = pdf_doc.page.margins[:left]
      y = pdf_doc.y - TestUtils.default_font.ascender
      [
        [x, y],
        [x + pdf_doc.width_of(expected_content[0]), y],
        [x + pdf_doc.width_of(expected_content[0] + test_content, inline_format: true), y]
      ]
    end
    let(:expected_font_settings) do
      [
        { name: :Helvetica, size: 12 },
        { name: expected_font_family.to_sym, size: 12 },
        { name: :Helvetica, size: 12 }
      ]
    end

    include_examples 'checks contents, positions and font settings'
  end

  context 'with some content in an element b' do
    it_behaves_like 'a specific element with some test content' do
      let(:test_content) { '<b>test</b>' }
      let(:expected_font_family) { 'Helvetica-Bold' }
    end
  end

  context 'with some content in an element em' do
    it_behaves_like 'a specific element with some test content' do
      let(:test_content) { '<em>test</em>' }
      let(:expected_font_family) { 'Helvetica-Oblique' }
    end
  end

  context 'with some content in an element i' do
    it_behaves_like 'a specific element with some test content' do
      let(:test_content) { '<i>test</i>' }
      let(:expected_font_family) { 'Helvetica-Oblique' }
    end
  end

  context 'with some content in an element strong' do
    it_behaves_like 'a specific element with some test content' do
      let(:test_content) { '<strong>test</strong>' }
      let(:expected_font_family) { 'Helvetica-Bold' }
    end
  end

  it 'renders some breaking line elements' do
    html = 'First line<br>Second line<br/>Third line'
    pdf = TestUtils.styled_text_document(html)
    text_analysis = PDF::Inspector::Text.analyze(pdf.render)

    expect(text_analysis.strings).to match_array(['First line', 'Second line', 'Third line'])
  end

  it 'renders an horizontal line element', skip: 'TODO' do
    pdf = TestUtils.styled_text_document('<hr>Some content')
    text_analysis = PDF::Inspector::Text.analyze(pdf.render)

    expect(text_analysis.strings).to eq(['Some content'])
    # text_analysis.positions # TODO: check text position
  end
end
