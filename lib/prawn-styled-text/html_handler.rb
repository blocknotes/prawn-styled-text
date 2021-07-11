# frozen_string_literal: true

require 'oga'
require_relative './document_renderer'

class HtmlHandler
  def initialize(pdf)
    @renderer = DocumentRenderer.new(pdf)
  end

  def after_element(_namespace, tag)
    t = tag.downcase.to_sym
    @parse = false if t == :body
    @renderer.context_pop(t) if @parse
    @styles = false if t == :style
  end

  def on_element(_namespace, tag, attrs = {})
    t = tag.downcase.to_sym
    @parse = true if t == :body
    @renderer.context_push(t, attrs) if @parse
    @styles = true if t == :style
  end

  def on_text(text)
    return @renderer.evaluate_styles(text) if @styles
    return unless @parse
    return if text =~ /\A\s*\Z/

    @renderer.prepare_content(text)
  end

  def process(html)
    @parse = !html.include?('<body')
    Oga.sax_parse_html(self, html)
    @renderer.flush
  end
end
