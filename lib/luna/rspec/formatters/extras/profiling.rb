# Frozen-string-literal: true
# Copyright: 2015 - 2020 - MIT License
# Author: Jordon Bedwell
# Encoding: utf-8

module Luna
  module Formatters
    module Profiling
      EXP = '  %<loc>s took %<sec>s'
      GROUPS = '  %<loc>s took %<count>g for %<sec>s'
      GROUPS_HEADER = "\nTop %<count>g slowest example groups:"
      EXP_HEADER = "\nTop %<count>g slowest examples (%<sec>gs), "\
        "%<percent>g%% of total time:\n"

      def helpers
        RSpec::Core::Formatters::Helpers
      end

      def dump_profile(profile)
        slowest_examples(profile)
        slowest_example_groups(
          profile
        )
      end

      private
      def slowest_examples(profile)
        examples_header(profile)

        profile.slowest_examples.map do |example|
          r_time = example.execution_result.run_time
          sec = helpers.format_seconds(
            r_time
          )

          sec = sec + ' seconds'
          @output.puts(
            format(EXP, {
              loc: format_caller(example.location),
              sec: sec.to_f < 1 ? success_color(sec) : failure_color(sec),
              dsc: example.full_description
            })
          )
        end
      end

      private
      def slowest_example_groups(profile)
        groups_header(profile)

        profile.slowest_groups.each do |l, h|
          sec = helpers.format_seconds(
            h[:total_time]
          )

          sec = sec + ' seconds'
          @output.puts color_blue(
            format(GROUPS, {
              desc: h[:description],
              sec: sec.to_f < 2 ? success_color(sec) : failure_color(sec),
              count: h[:count],
              loc: color_blue(
                strip_relative(l)
              )
            })
          )
        end
      end

      private
      def groups_header(profile)
        @output.puts(
          format(GROUPS_HEADER, {
            count: profile.slowest_groups.size
          })
        )
      end

      private
      def examples_header(profile)
        @output.puts(
          format(EXP_HEADER, {
            count: profile.slowest_examples.size,
            percent: profile.percentage,
            sec: helpers.format_seconds(
              profile.slow_duration
            )
          })
        )
      end

      private
      def color_blue(str)
        RSpec::Core::Formatters::ConsoleCodes.wrap(
          str, :cyan
        )
      end

      private
      def strip_relative(path)
        path.gsub(
          %r!\A\./!, ''
        )
      end

      private
      def format_caller(caller_info)
        color_blue strip_relative(
          ::RSpec.configuration.backtrace_formatter.backtrace_line(
            caller_info.to_s.split(":in `block'").first
          )
        )
      end
    end
  end
end
