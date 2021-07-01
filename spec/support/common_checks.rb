# frozen_string_literal: true

RSpec.shared_examples 'checks contents and positions' do
  it 'matches the expected contents and positions' do
    text_analysis = PDF::Inspector::Text.analyze(pdf_doc.render)
    expect(text_analysis.strings).to eq expected_content
    expect(text_analysis.positions).to eq [[expected_x, expected_y]]
  end
end

RSpec.shared_examples 'checks contents, positions and font settings' do
  it 'matches the expected contents, positions and font settings' do
    text_analysis = PDF::Inspector::Text.analyze(pdf_doc.render)
    expect(text_analysis.strings).to eq expected_content
    expect(text_analysis.positions).to eq [[expected_x, expected_y]]
    expect(text_analysis.font_settings).to eq [{ name: expected_font_family, size: expected_font_size }]
  end
end
