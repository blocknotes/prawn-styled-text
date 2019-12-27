# frozen_string_literal: true

$LOAD_PATH << '../lib'

require 'prawn'
require 'prawn-styled-text'
require 'oga'

pdf = Prawn::Document.new
html = File.read('basic.html')
HtmlHandler.new(pdf, html).process
pdf.render_file('basic.pdf')
