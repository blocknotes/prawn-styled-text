# frozen_string_literal: true

RSpec.describe 'Misc' do
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
