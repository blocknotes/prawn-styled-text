# frozen_string_literal: true

RSpec.describe 'Styles' do
  let(:pdf_doc) { TestUtils.styled_text_document(html) }

  describe 'attribute text-align' do
    context 'with some content left aligned' do
      let(:html) { '<div style="text-align: left">Some content</div>' }

      let(:expected_content) { ['Some content'] }
      let(:expected_x) { pdf_doc.page.margins[:left] }
      let(:expected_y) { pdf_doc.y - TestUtils.default_font.ascender }

      include_examples 'checks contents and positions'
    end

    context 'with some content center aligned' do
      let(:html) { '<div style="text-align: center">Some content</div>' }

      let(:content_width) { pdf_doc.width_of(expected_content.first) }
      let(:expected_content) { ['Some content'] }
      let(:expected_x) { (pdf_doc.page.margins[:left] + (pdf_doc.bounds.width - content_width) / 2).round(3) }
      let(:expected_y) { pdf_doc.y - TestUtils.default_font.ascender }

      include_examples 'checks contents and positions'
    end

    context 'with some content right aligned' do
      let(:html) { '<div style="text-align: right">Some content</div>' }

      let(:content_width) { pdf_doc.width_of(expected_content.first) }
      let(:expected_content) { ['Some content'] }
      let(:expected_x) { pdf_doc.page.margins[:left] + pdf_doc.bounds.width - content_width }
      let(:expected_y) { pdf_doc.y - TestUtils.default_font.ascender }

      include_examples 'checks contents and positions'
    end
  end

  describe 'attribute font-family' do
    context 'with some content with Courier font' do
      let(:html) { '<div style="font-family: Courier">Some content</div>' }

      let(:expected_content) { ['Some content'] }
      let(:expected_x) { pdf_doc.page.margins[:left] }
      let(:expected_y) { pdf_doc.y - Prawn::Document.new.font('Courier', size: 12).ascender }
      let(:expected_font_family) { :Courier }
      let(:expected_font_size) { 12 }

      include_examples 'checks contents, positions and font settings'
    end
  end

  describe 'attribute font-size' do
    context 'with some content with a font size of 20px' do
      let(:html) { '<div style="font-size: 20px">Some content</div>' }

      let(:expected_content) { ['Some content'] }
      let(:expected_x) { pdf_doc.page.margins[:left] }
      let(:expected_y) { pdf_doc.y - Prawn::Document.new.font('Helvetica', size: 20).ascender }
      let(:expected_font_family) { :Helvetica }
      let(:expected_font_size) { 20 }

      include_examples 'checks contents, positions and font settings'
    end
  end

  describe 'attribute font-style' do
    context 'with some content with bold style' do
      let(:html) { '<div style="font-style: bold">Some content</div>' }

      let(:expected_content) { ['Some content'] }
      let(:expected_x) { pdf_doc.page.margins[:left] }
      let(:expected_y) { pdf_doc.y - Prawn::Document.new.font('Helvetica-Bold', size: 12).ascender }
      let(:expected_font_family) { :'Helvetica-Bold' }
      let(:expected_font_size) { 12 }

      include_examples 'checks contents, positions and font settings'
    end

    context 'with some content with bold style' do
      let(:html) { '<div style="font-style: bold">Some content</div>' }

      let(:expected_content) { ['Some content'] }
      let(:expected_x) { pdf_doc.page.margins[:left] }
      let(:expected_y) { pdf_doc.y - Prawn::Document.new.font('Helvetica-Bold', size: 12).ascender }
      let(:expected_font_family) { :'Helvetica-Bold' }
      let(:expected_font_size) { 12 }

      include_examples 'checks contents, positions and font settings'
    end

    context 'with some content with italic style' do
      let(:html) { '<div style="font-style: italic">Some content</div>' }

      let(:expected_content) { ['Some content'] }
      let(:expected_x) { pdf_doc.page.margins[:left] }
      let(:expected_y) { pdf_doc.y - Prawn::Document.new.font('Helvetica-Oblique', size: 12).ascender }
      let(:expected_font_family) { :'Helvetica-Oblique' }
      let(:expected_font_size) { 12 }

      include_examples 'checks contents, positions and font settings'
    end

    context 'with some content with bold italic style' do
      let(:html) { '<div style="font-style: bold, italic">Some content</div>' }

      let(:expected_content) { ['Some content'] }
      let(:expected_x) { pdf_doc.page.margins[:left] }
      let(:expected_y) { pdf_doc.y - Prawn::Document.new.font('Helvetica-BoldOblique', size: 12).ascender }
      let(:expected_font_family) { :'Helvetica-BoldOblique' }
      let(:expected_font_size) { 12 }

      include_examples 'checks contents, positions and font settings'
    end
  end

  describe 'attribute letter-spacing' do
    it 'renders some content with letter spacing' do
      html = '<div style="letter-spacing: 1.5">aaa</div> bbb <div style="letter-spacing: 2">ccc</div>'
      pdf = TestUtils.styled_text_document(html)
      text_analysis = PDF::Inspector::Text.analyze(pdf.render)

      expect(text_analysis.strings).to eq(%w[aaa bbb ccc])
      expect(text_analysis.character_spacing).to eq([1.5, 0.0] * 3 + [2.0, 0.0] * 3)
    end
  end

  describe 'attribute margin-left' do
    let(:html) { '<div style="margin-left: 40px">Some content</div>' }

    let(:expected_content) { ['Some content'] }
    let(:expected_x) { pdf_doc.page.margins[:left] + 40 }
    let(:expected_y) { pdf_doc.y - Prawn::Document.new.font('Helvetica', size: 12).ascender }

    include_examples 'checks contents and positions'
  end

  describe 'attribute margin-top' do
    let(:html) { '<div style="margin-top: 40">Some content</div>' }

    let(:expected_content) { ['Some content'] }
    let(:expected_x) { pdf_doc.page.margins[:left] }
    let(:expected_y) { pdf_doc.y - Prawn::Document.new.font('Helvetica', size: 12).ascender - 40 }

    include_examples 'checks contents and positions'
  end
end
