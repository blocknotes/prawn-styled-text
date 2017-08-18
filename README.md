# Prawn Styled Text [![Gem Version](https://badge.fury.io/rb/prawn-styled-text.svg)](https://badge.fury.io/rb/prawn-styled-text)

A Prawn PDF component which adds basic HTML support.

**Important**: render HTML documents is not an easy task; only a small set of tags and attributes are supported and complex layouts will not render correctly; if you look for real HTML to PDF convertion please try other gems like WickedPDF

## Supported tags & attributes

HTML tags:
- a
- b
- br 
- div
- h1 - h6
- hr
- i
- img
- span
- u
- ul / li

CSS attributes:
- color (*only 6 hex digits format, # is ignored, ex. FFBB11*)
- font-family
- font-size (*units are ignored*)
- font-style (*accepts list of values, ex. bold, italic*)
- href (*tag a*)
- letter-spacing
- line-height (*as heading, units are ignored*)
- margin-left (*units are ignored*)
- margin-top (*units are ignored*)
- src (*tag img*)
- text-align

## Examples

See [examples](https://github.com/blocknotes/prawn-styled-text/tree/master/examples) folder.

## Contributors

- [Mattia Roccoberton](http://blocknot.es) - creator, maintainer

## License

[MIT](LICENSE.txt)
