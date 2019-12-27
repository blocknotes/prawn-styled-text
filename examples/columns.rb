# frozen_string_literal: true

$LOAD_PATH << '../lib'

require 'prawn'
require 'prawn-styled-text'
require 'oga'

html = <<~CONTENT
  <div style="font-size: 16px; text-align: justify">Lorem ipsum dolor sit <b>amet</b>, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud <i>exercitation</i> ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in <u>reprehenderit</u> in voluptate velit esse cillum dolore eu fugiat nulla pariatur.<br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    <br/>
  </div>
CONTENT

pdf = Prawn::Document.new
pdf.styled_text '<h1 style="text-align: center">2 columns</h1>'
pdf.column_box([0, pdf.cursor], columns: 2, width: pdf.bounds.width) do
  pdf.styled_text(html * 4)
end
pdf.render_file('columns.pdf')
