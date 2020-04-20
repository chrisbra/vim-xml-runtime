# vim-xml-ftplugin [![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/cb%40256bit.org)
Vim xml runtime files

The official XML runtime files for Vim. They include:
* XML [filetype plugin][1]
* XML [indent script][2]
* XML [format script][3]
* XML [syntax script][4]

Once in a while, a snapshot from here will be send to Bram for inclusion and distribution with [Vim][5]

This filetype plugin contains an xmlformatting plugin in the autoload directory:

### XMLFormat
> A Vim plugin to pretty print xml

This plugin tries to format xml prettier. To use it, set the `formatexpr` option in Vim to `xmlformat#Format()` and reformat your document using `gq`

### Installation
Use the plugin manager of your choice.

### Usage

In your XML document enter:
```
:set formatexpr=xmlformat#Format()
```
Then reformat using `gq`

### License & Copyright

© 2018 by Christian Brabandt. The Vim license (see `:h license`) applies to the Vim plugin, the shell script is licensed under the BSD license.

__NO WARRANTY, EXPRESS OR IMPLIED.  USE AT-YOUR-OWN-RISK__

[1]: https://github.com/chrisbra/vim-xml-ftplugin/blob/master/ftplugin/xml.vim
[2]: https://github.com/chrisbra/vim-xml-ftplugin/blob/master/indent/xml.vim
[3]: https://github.com/chrisbra/vim-xml-ftplugin/blob/master/autoload/xmlformat.vim
[4]: https://github.com/chrisbra/vim-xml-ftplugin/blob/master/syntax/xml.vim
[5]: https://www.github.com/vim/vim
