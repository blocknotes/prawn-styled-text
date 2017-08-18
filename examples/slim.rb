require 'prawn'
require 'prawn-styled-text'
require 'oga'
require 'slim'

SLIM_FILE = 'test.html.slim'

Prawn::Font::AFM.hide_m17n_warning = true

pdf = Prawn::Document.new
pdf.text "\nA test document\n", align: :center, size: 18
# Slim::Template.new{ 'h1 A test document' }.render
pdf.styled_text Slim::Template.new( SLIM_FILE ).render
pdf.render_file 'test.pdf'
