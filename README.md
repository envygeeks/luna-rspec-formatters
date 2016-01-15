## Luna RSpec Formatters

```ruby
gem "luna-rspec-formatters"
```

A set of `rspec` formatters that design things the way I like them.  `fulldesc`
is a formatter that outputs the full description as a single line rather than
nesting like documentation and `Checks` displays checkmark's and other UTF
characters rather than dots.

```ruby
require "luna/rspec/formatters/checks"
require "luna/rspec/formatters/fulldesc"
require "luna/rspec/formatters/smilies"
require "luna/rspec/formatters/hearts"
require "luna/rspec/formatters/cats"
```
