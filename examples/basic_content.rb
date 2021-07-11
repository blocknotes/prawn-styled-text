# frozen_string_literal: true

$LOAD_PATH << '../lib'

require 'prawn'
require 'prawn-styled-text'
require 'oga'

html = File.read(File.expand_path('./basic_content.html', __dir__))
pdf = Prawn::Document.new
HtmlHandler.new(pdf).process(html)
pdf.render_file('basic_content.pdf')
