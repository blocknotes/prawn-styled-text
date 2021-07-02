# frozen_string_literal: true

RSpec.describe 'Random content' do
  context 'with some random content' do
    let(:html) { File.read(File.expand_path('../fixtures/random_content.html', __dir__)) }

    it 'renders the expected output' do
      pdf_doc = TestUtils.styled_text_document(html)
      expected_pdf = File.read(File.expand_path('../fixtures/random_content.pdf', __dir__))

      expect(Zlib.crc32(pdf_doc.render)).to eq Zlib.crc32(expected_pdf)
    end
  end
end
