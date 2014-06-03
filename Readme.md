## RSpec Formatters Luna

```ruby
gem "luna-rspec-formatters"
```

A set of `rspec` formatters that design things the way I like them.  `Doc2` is
a formatter that outputs the full description as a single line rather than
nesting like documentation and `Checks` displays checkmark's and other UTF
characters rather than dots.

```ruby
require "luna/rspec/formatters/checks"
require "luna/rspec/formatters/documentation"
```
