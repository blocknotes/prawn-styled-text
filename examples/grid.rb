require 'prawn'
require 'prawn-styled-text'
require 'oga'

html = <<~EOL
  <h4 style="text-align: center">Some text</h4>
  <div style="font-size: 10px; text-align: justify">Lorem ipsum dolor sit <b>amet</b>, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud <i>exercitation</i> ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in <u>reprehenderit</u> in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div>
EOL

# html = <<~EOL
#   <span>span 1</span>
#   <div>div 1</div>
#   <span>span 2</span>
#   <div>div 2</div>
#   <span>span 3</span>
#   <span>span 4</span>
#   <div>div 3</div>
#   <div>div 4</div>
# EOL

pdf = Prawn::Document.new
pdf.define_grid(:columns => 3, :rows => 3, :gutter => 10)
pdf.grid( 1, 1 ).bounding_box do
  pdf.styled_text html
end
pdf.render_file 'test.pdf'
