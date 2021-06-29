# frozen_string_literal: true

RSpec.describe 'Headings' do
  def base_position(pdf, font_size, margin_top: 16)
    font = Prawn::Document.new.font('Helvetica', size: font_size)
    [pdf.page.margins[:left], pdf.y - font.ascender - margin_top]
  end

  it 'renders an header tag: h1' do
    pdf = TestUtils.prepare_document('<h1>header with tag h1</h1>')
    text_analysis = PDF::Inspector::Text.analyze(pdf.render)

    expect(text_analysis.strings).to match_array('header with tag h1')
    expect(text_analysis.font_settings).to match_array([{ name: TestUtils.default_font(pdf), size: 32 }])
    expect(text_analysis.positions).to match_array([base_position(pdf, 32)])
  end

  it 'renders an header tag: h2' do
    pdf = TestUtils.prepare_document('<h2>header with tag h2</h2>')
    text_analysis = PDF::Inspector::Text.analyze(pdf.render)

    expect(text_analysis.strings).to match_array('header with tag h2')
    expect(text_analysis.font_settings).to match_array([{ name: TestUtils.default_font(pdf), size: 24 }])
    expect(text_analysis.positions).to match_array([base_position(pdf, 24)])
  end

  it 'renders an header tag: h3' do
    pdf = TestUtils.prepare_document('<h3>header with tag h3</h3>')
    text_analysis = PDF::Inspector::Text.analyze(pdf.render)

    expect(text_analysis.strings).to match_array('header with tag h3')
    expect(text_analysis.font_settings).to match_array([{ name: TestUtils.default_font(pdf), size: 20 }])
    expect(text_analysis.positions).to match_array([base_position(pdf, 20)])
  end

  it 'renders an header tag: h4' do
    pdf = TestUtils.prepare_document('<h4>header with tag h4</h4>')
    text_analysis = PDF::Inspector::Text.analyze(pdf.render)

    expect(text_analysis.strings).to match_array('header with tag h4')
    expect(text_analysis.font_settings).to match_array([{ name: TestUtils.default_font(pdf), size: 16 }])
    expect(text_analysis.positions).to match_array([base_position(pdf, 16)])
  end

  it 'renders an header tag: h5' do
    pdf = TestUtils.prepare_document('<h5>header with tag h5</h5>')
    text_analysis = PDF::Inspector::Text.analyze(pdf.render)

    expect(text_analysis.strings).to match_array('header with tag h5')
    expect(text_analysis.font_settings).to match_array([{ name: TestUtils.default_font(pdf), size: 14 }])
    expect(text_analysis.positions).to match_array([base_position(pdf, 14)])
  end

  it 'renders an header tag: h6' do
    pdf = TestUtils.prepare_document('<h6>header with tag h6</h6>')
    text_analysis = PDF::Inspector::Text.analyze(pdf.render)

    expect(text_analysis.strings).to match_array('header with tag h6')
    expect(text_analysis.font_settings).to match_array([{ name: TestUtils.default_font(pdf), size: 13 }])
    expect(text_analysis.positions).to match_array([base_position(pdf, 13)])
  end
end
