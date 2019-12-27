# Prawn Styled Text
[![gem version](https://badge.fury.io/rb/prawn-styled-text.svg)](https://badge.fury.io/rb/prawn-styled-text)
[![gem downloads](https://badgen.net/rubygems/dt/prawn-styled-text)](https://rubygems.org/gems/prawn-styled-text)
[![linters](https://github.com/blocknotes/prawn-styled-text/actions/workflows/linters.yml/badge.svg)](https://github.com/blocknotes/prawn-styled-text/actions/workflows/linters.yml)
[![specs](https://github.com/blocknotes/prawn-styled-text/actions/workflows/specs.yml/badge.svg)](https://github.com/blocknotes/prawn-styled-text/actions/workflows/specs.yml)

A Prawn PDF component which adds basic HTML support.

**Important**: render HTML documents is not an easy task; only a small set of tags and attributes are supported and complex layouts will not render correctly; if you look for real HTML to PDF conversion please try other gems like WickedPDF.

Please :star: if you like it.

## Install

- Add to your Gemfile: `gem 'prawn-styled-text'` (and execute `bundle`)
- Use the class `HtmlHandler` on a `Prawn::Document` instance

## Examples

```ruby
require 'prawn-styled-text'
pdf = Prawn::Document.new
::HtmlHandler.new(pdf).process('<h1 style="text-align: center">Just a test</h1>')
pdf.render_file 'test.pdf'
```

For more examples see this [folder](https://github.com/blocknotes/prawn-styled-text/tree/master/examples).

## Supported tags & attributes

HTML tags:

- **a**: link
- **b**: bold
- **br**: new line
- **del**: strike-through
- **div**: block element
- **em**: italic
- **h1** - **h6**: headings
- **hr**: horizontal line
- **i**: italic
- **ins**: underline
- **img**: image
- **li**: list item
- **mark**: highlight
- **p**: block element
- **s**: strike-through
- **small**: smaller text
- **span**: inline element
- **strong**: bold
- **u**: underline
- **ul**: list

CSS attributes:

- **background**: for *mark* tag, only 3 or 6 hex digits format, ex. `style="background: #FECD08"`
- **color**: only 3 or 6 hex digits format - ex. `style="color: #FB1"`
- **font-family**: font must be registered, quotes are optional, ex. `style="font: Courier"`
- **font-size**: units are ignored - ex. `style="font-size: 20px"`
- **font-style**: values: *:italic*, *:normal*, ex. `style="font-style: italic"`
- **font-weight**: values: *:bold*, *:normal*, ex. `style="font-weight: bold"`
- **height**: for *img* tag, ex. `<img src="image.jpg" style="width: 50%; height: 200"/>`
- **href**: for *a* tag, ex. `<a href="http://www.google.com/">Google</a>`
- **letter-spacing**: ex. `style="letter-spacing: 1.5"`
- **line-height**: heading, units are ignored - ex. `style="line-height: 10"`
- **margin-left**: units are ignored - ex. `style="margin-left: 15"`
- **margin-top**: units are ignored - ex. `style="margin-top: 20"`
- **src**: for *img* tag, ex. `<img src="image.jpg"/>`
- **text-align**: ex. `style="text-align: center"`
- **width**: for *img* tag, ex. `<img src="image.jpg" style="width: 50%; height: 200"/>`

See [Prawn documentation](https://github.com/prawnpdf/prawn-table#documentation) for PDF options details.

## Contributors

- [Mattia Roccoberton](https://www.blocknot.es): author

## License

The gem is available as open-source under the terms of the [MIT](LICENSE.txt).
