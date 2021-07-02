# frozen_string_literal: true

RSpec.describe 'Basic content' do
  context 'with some basic content' do
    let(:html) do
      <<~CONTENT
        <div style="font-size: 16px; text-align: justify">Lorem ipsum dolor sit <b>amet</b>, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud <i>exercitation</i> ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in <u>reprehenderit</u> in voluptate velit esse cillum dolore eu fugiat nulla pariatur.<br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
          <br/>
        </div>
      CONTENT
    end

    it 'renders the expected output' do
      pdf_doc = TestUtils.styled_text_document(html)
      path = File.expand_path('../fixtures/basic_content.pdf', __dir__)
      expected_pdf = File.read(path)

      expect(Zlib.crc32(pdf_doc.render)).to eq Zlib.crc32(expected_pdf)
    end
  end
end
