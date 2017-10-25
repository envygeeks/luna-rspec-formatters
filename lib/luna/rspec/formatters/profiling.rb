# Frozen-string-literal: true
# Copyright: 2015 - 2017 Jordon Bedwell - MIT License
# Encoding: utf-8

module Luna
  module Formatters
    module Profiling
      GROUPS = "  %{l} \u2910 %{c} for %{t}"
      EXAMPLES_HEADER = "\nTop %{s} slowest examples (%{t}s), %{p}%% of total time:\n"
      GROUPS_HEADER = "\nTop %{s} slowest example groups:"
      EXAMPLES = "  %{l} \u2910 %{s}"

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

          @output.puts EXAMPLES % {
            :l => format_caller(e.location),
            :s => sec.to_f < 1 ? success_color(sec) : failure_color(sec),
            :d => e.full_description
          }
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

          @output.puts color_blue(GROUPS % {
            :d => h[:description],
            :t => sec.to_f < 2 ? success_color(sec) : failure_color(sec),
            :l => color_blue(strip_relative(l)),
            :c => h[:count]
          })
        end
      end

      # --
      # Headers group.
      # --
      private
      def groups_header(profile)
        @output.puts GROUPS_HEADER % {
          :s => profile.slowest_groups.size
        }
      end

      # --
      # Header example.
      # --
      private
      def examples_header(profile)
        @output.puts EXAMPLES_HEADER % {
          :s => profile.slowest_examples.size,
          :t => helpers.format_seconds(profile.slow_duration),
          :p => profile.percentage
        }
      end

      # --
      private
      def color_blue(str)
        Object::RSpec::Core::Formatters::ConsoleCodes.wrap(
          str, :cyan
        )
      end

      # --
      private
      def strip_relative(path)
        path.gsub(
          /\A\.\//, ""
        )
      end

      # --
      private
      def format_caller(caller_info)
        color_blue strip_relative(::RSpec.configuration.backtrace_formatter.
        backtrace_line(
          caller_info.to_s.split(':in `block').first
        ))
      end
    end
  end
end
