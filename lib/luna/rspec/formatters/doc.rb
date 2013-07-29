require_relative "shared/base"

module Luna
  module RSpec
    module Formatters
      class Doc < Base

        # --------------------------------------------------------------------
        # example_passed, example_pending, example_failed.
        # --------------------------------------------------------------------

        MethodMap.each do |m, u|
          define_method("example_#{m}") do |e|
            super(e)
            blank_line?
            print_description(e)
            output.puts " #{u.first}".send(u.last)
          end
        end

        # --------------------------------------------------------------------
        # A simple wrapper for CodeRay and syntax highlighting.
        # --------------------------------------------------------------------

        def syntax_highlight(text)
          CodeRay.scan(text, :ruby).term
        end

        # --------------------------------------------------------------------
        # Searches for `` inside of "it" and and highlights it with CodeRay.
        # --------------------------------------------------------------------

        def highlight_graves(text)
          text.gsub(/`([^`]+)`/) { syntax_highlight($1) }
        end

        # --------------------------------------------------------------------
        # Searches for anything that starts with \. or # and colors it.
        # --------------------------------------------------------------------

        def highlight_methods(text)
          text.gsub(/(#|\.)([a-z0-9_]+)/) { $1.white + $2.magenta }
        end

        # --------------------------------------------------------------------
        # Strips apart the full_description to attempt to gather information
        # on the constant and method and then highlights and outputs
        # everything.
        # --------------------------------------------------------------------

        def print_description(example)
          constant = example.full_description.chomp(example.description)
          output.print "  " + highlight_methods(syntax_highlight(constant))
          output.print highlight_graves(example.description) + ":"
        end
      end
    end
  end
end
