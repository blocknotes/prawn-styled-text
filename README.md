# Prawn Styled Text [![Gem Version](https://badge.fury.io/rb/prawn-styled-text.svg)](https://badge.fury.io/rb/prawn-styled-text)

A Prawn PDF component which adds basic HTML support.

**Important**: render HTML documents is not an easy task; only a small set of tags and attributes are supported and complex layouts will not render correctly; if you look for real HTML to PDF convertion please try other gems like WickedPDF

Install with `gem install prawn-styled-text` or using bundler `gem 'prawn-styled-text'`

## Examples

```ruby
require 'prawn-styled-text'
pdf = Prawn::Document.new
pdf.styled_text '<h1 style="text-align: center">Just a test</h1>'
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
- **background**: for *mark* tag, only 6 hex digits format, # is ignored - ex. `style="background: #FFCC00"`
- **color**: only 6 hex digits format, # is ignored - ex. `style="color: #FFBB11"`
- **font-family**: font must be registered, quotes are optional, ex. `style="font: Courier"`
- **font-size**: units are ignored - ex. `style="font-size: 20px"`
- **font-style**: values: *:bold*, *:bold_italic*, *:italic*, *:normal*; string or comma separated strings - ex. `style="font-style: bold, italic"`
- **height**: for *img* tag, ex. `<img src="image.jpg" style="width: 50%; height: 200"/>`
- **href**: for *a* tag, ex. `<a href="http://www.google.com/">Google</a>`
- **letter-spacing**: ex. `style="letter-spacing: 1.5"`
- **line-height**: heading, units are ignored - ex. `style="line-height: 10"`
- **margin-left**: units are ignored - ex. `style="margin-left: 15"`
- **margin-top**: units are ignored - ex. `style="margin-top: 20"`
- **src**: for *img* tag, ex. `<img src="image.jpg"/>`
- **text-align**: ex. `style="text-align: center"`
- **width**: for *img* tag, ex. `<img src="image.jpg" style="width: 50%; height: 200"/>`

Olther attributes:
- **dash**: for *hr* tag, dash types, integer or comma separated integers, ex. `<hr style="dash: 4"/>`
- **image-at**: for *img* tag, origin (0, 0) is left bottom, ex. `<img src="image.jpg" style="image-at: 100, 600" />`
- **image-position**: for *img* tag, ex. `<img src="image.jpg" style="image-position: center" />`
- **image-scale**: for *img* tag, ex. `<img src="image.jpg" style="image-scale: 0.3" />`
- **list-symbol**: for *ul* tag, ex. `<ul style="list-symbol: -">`
- **mode**: text mode, values: *:clip*, *:fill*, *:fill_clip*, *:fill_stroke*, *:fill_stroke_clip*, *:invisible*, *:stroke*, *:stroke_clip*, ex. `<h3 style="mode: stroke">Stroke text</h3>`

See [Prawn documentation](https://github.com/prawnpdf/prawn-table#documentation) for PDF options details.

## Contributors

- [Mattia Roccoberton](http://blocknot.es) - creator, maintainer

## License

[MIT](LICENSE.txt)
