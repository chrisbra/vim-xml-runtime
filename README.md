# XMLFormat
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
