# frozen_string_literal: true

RSpec.describe 'Lists' do
  context 'with an empty ul list' do
    it 'renders no strings' do
      html = <<~HTML
        <ul>
        </ul>
      HTML

      pdf = TestUtils.prepare_document(html)
      text_analysis = PDF::Inspector::Text.analyze(pdf.render)

      expect(text_analysis.strings).to be_empty
      expect(text_analysis.font_settings).to be_empty
      expect(text_analysis.positions).to be_empty
    end
  end

  context 'with an ul list' do
    it 'renders the list of elements' do
      html = <<~HTML
        <ul>
          <li>First item</li>
          <li>Second item</li>
          <li>Third item</li>
        </ul>
      HTML

      pdf = TestUtils.prepare_document(html)
      text_analysis = PDF::Inspector::Text.analyze(pdf.render)

      expected_array = [{ name: TestUtils.default_font(pdf), size: pdf.font_size }] * 3

      expect(text_analysis.strings).to match_array(['• First item', '• Second item', '• Third item'])
      expect(text_analysis.font_settings).to match_array(expected_array)

      font = Prawn::Document.new.font
      x = pdf.page.margins[:left] + PrawnStyledText::DEF_MARGIN_UL
      y = pdf.y - font.ascender
      expected_array = [[x, y], [x, (y - font.height).round(3)], [x, (y - font.height * 2).round(3)]]

      expect(text_analysis.positions).to match_array(expected_array)
    end
  end
end
