# frozen_string_literal: true

require 'oga'
require_relative './document_renderer'

class HtmlHandler
  def initialize(pdf, html)
    @elements = []
    @html = html
    @renderer = DocumentRenderer.new(pdf)
  end

  def after_element(_namespace, tag)
    @parse = false if tag.downcase == 'body'
    @renderer.context_pop if @parse
    @styles = false if tag.downcase == 'style'
  end

  def on_element(_namespace, tag, attrs = {})
    @parse = true if tag.downcase == 'body'
    @renderer.context_push(tag.downcase.to_sym, attrs) if @parse
    @styles = true if tag.downcase == 'style'
  end

  def on_text(text)
    return @renderer.evaluate_styles(text) if @styles
    return if !@parse || text.strip.empty?

    content = text.gsub(/\n/, '').gsub(/\s+/, ' ')
    @renderer.prepare_content(content)
  end

  def process
    @parse = !@html.include?('<body')
    Oga.sax_parse_xml(self, @html)
    @renderer.flush
  end
end
