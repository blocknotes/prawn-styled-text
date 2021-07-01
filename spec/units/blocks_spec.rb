# frozen_string_literal: true

RSpec.describe 'Blocks' do
  it 'renders some contents in a div' do
    html = '<div>Some content in a div element</div>'
    pdf = TestUtils.styled_text_document(html)
    text_analysis = PDF::Inspector::Text.analyze(pdf.render)

    expect(text_analysis.strings).to eq ['Some content in a div element']
    expect(text_analysis.font_settings).to eq [{ name: TestUtils.default_font(pdf), size: pdf.font_size }]

    font = Prawn::Document.new.font
    expect(text_analysis.positions).to eq [[pdf.page.margins[:left], pdf.y - font.ascender]]
  end

  it 'renders some contents in a p' do
    html = '<p>Some content in a p element</p>'
    pdf = TestUtils.styled_text_document(html)
    text_analysis = PDF::Inspector::Text.analyze(pdf.render)

    expect(text_analysis.strings).to eq ['Some content in a p element']
    expect(text_analysis.font_settings).to eq [{ name: TestUtils.default_font(pdf), size: pdf.font_size }]

    font = Prawn::Document.new.font
    expect(text_analysis.positions).to eq [[pdf.page.margins[:left], pdf.y - font.ascender]]
  end
end
