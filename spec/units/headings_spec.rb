# frozen_string_literal: true

RSpec.describe 'Headings' do
  it 'renders an header tag: h1' do
    pdf = Prawn::Document.new
    pdf.styled_text '<h1>Just a test</h1>'
    text_analysis = PDF::Inspector::Text.analyze(pdf.render)

    expect(text_analysis.strings).to match_array('Just a test')
    expect(text_analysis.font_settings).to match_array([{ name: :Helvetica, size: 32 }])
  end
end
