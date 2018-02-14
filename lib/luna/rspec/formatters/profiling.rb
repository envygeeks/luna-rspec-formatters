# Frozen-string-literal: true
# Copyright: 2015 - 2018 - MIT License
# Author: Jordon Bedwell
# Encoding: utf-8

module Luna
  module Formatters
    module Profiling
      EXP = "  %<loc>s \u2910 %<sec>s"
      GROUPS = "  %<loc>s \u2910 %<count>g for %<sec>s"
      GROUPS_HEADER = "\nTop %<count>g slowest example groups:"
      EXP_HEADER = "\nTop %<count>g slowest examples (%<sec>gs), "\
        "%<percent>g%% of total time:\n"

      # --
      # Help.
      # --
      def helpers
        RSpec::Core::Formatters::Helpers
      end

      # --
      # Profile.
      # --
      def dump_profile(profile)
        dump_profile_slowest_examples(profile)
        dump_profile_slowest_example_groups(
          profile
        )
      end

      # --
      # Slow examples.
      # --
      private
      def dump_profile_slowest_examples(profile)
        examples_header(profile)

        profile.slowest_examples.each do |e|
          sec = helpers.format_seconds(e.execution_result.run_time)
          sec = sec + " seconds"

          @output.puts format(EXP, {
            loc: format_caller(e.location),
            sec: sec.to_f < 1 ? success_color(sec) : failure_color(sec),
            desc: e.full_description,
          })
        end
      end

      # --
      # Slowest example groups.
      # --
      private
      def dump_profile_slowest_example_groups(profile)
        groups_header(profile)

        profile.slowest_groups.each do |l, h|
          sec = helpers.format_seconds(h[:total_time])
          sec = sec + " seconds"

          @output.puts color_blue(format(GROUPS, {
            desc: h[:description],
            sec: sec.to_f < 2 ? success_color(sec) : failure_color(sec),
            loc: color_blue(strip_relative(l)),
            count: h[:count],
          }))
        end
      end

      # --
      # Headers group.
      # --
      private
      def groups_header(profile)
        @output.puts format(GROUPS_HEADER, {
          count: profile.slowest_groups.size,
        })
      end

      # --
      # Header example.
      # --
      private
      def examples_header(profile)
        @output.puts format(EXP_HEADER, {
          count: profile.slowest_examples.size,
          sec: helpers.format_seconds(profile.slow_duration),
          percent: profile.percentage,
        })
      end

      # --
      private
      def color_blue(str)
        RSpec::Core::Formatters::ConsoleCodes
          .wrap(str, :cyan)
      end

      # --
      private
      def strip_relative(path)
        path.gsub(%r!\A\./!, "")
      end

      # --
      private
      def format_caller(caller_info)
        color_blue strip_relative(::RSpec.configuration.backtrace_formatter
          .backtrace_line(caller_info.to_s.split(":in `block'").first))
      end
    end
  end
end
