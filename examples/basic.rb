$LOAD_PATH << '../lib'

require 'prawn'
require 'prawn-styled-text'
require 'oga'

Prawn::Font::AFM.hide_m17n_warning = true

pdf = Prawn::Document.new
pdf.styled_text File.read( 'test.html' )
pdf.render_file 'test.pdf'
