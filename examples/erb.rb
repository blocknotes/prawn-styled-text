# frozen_string_literal: true

$LOAD_PATH << '../lib'

require 'erb'
require 'prawn'
require 'prawn-styled-text'
require 'oga'

ERB_FILE = 'test.html.erb'

Prawn::Font::AFM.hide_m17n_warning = true

pdf = Prawn::Document.new
pdf.text("\nA test document\n", align: :center, size: 18)
pdf.styled_text ERB.new(File.read(ERB_FILE)).result(binding)
pdf.render_file('erb.pdf')
