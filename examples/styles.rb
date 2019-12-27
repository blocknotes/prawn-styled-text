# frozen_string_literal: true

$LOAD_PATH << '../lib'

require 'prawn'
require 'prawn-styled-text'
require 'oga'

pdf = Prawn::Document.new

html = <<~HTML
  <!DOCTYPE html>
  <html>
  <head>
    <title>A test</title>
    <style>
      body { color: #f00 }
      p { color: #00f; font-size: 8px }
      .green { color: #0f0 }
    </style>
  </head>
  <body>
    <div>test</div>
    <p style="padding-left: 10; padding-top: 20; padding-bottom: 15">
      <div>test 1</div>
      <div class="green">test 2</div>
    </p>
    <div>test 3</div>
  </body>
  </html>
HTML

HtmlHandler.new(pdf, html).process
pdf.render_file('styles.pdf')
