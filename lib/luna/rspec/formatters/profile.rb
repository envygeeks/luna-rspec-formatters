# ----------------------------------------------------------------------------
# Frozen-string-literal: true
# Copyright: 2015 - 2016 Jordon Bedwell - MIT License
# Encoding: utf-8
# ----------------------------------------------------------------------------

module Luna
  module RSpec
    module Formatters
      module Profile
        GROUPS = "  %{location} \u2910 %{count} for %{total}"
        EXAMPLES_HEADER = "\nTop %{size} slowest examples (%{seconds}s), %{per_cent}%% of total time:\n"
        GROUPS_HEADER = "\nTop %{size} slowest example groups:"
        EXAMPLES = "  %{location} \u2910 %{seconds}"

        # --------------------------------------------------------------------

        def helpers
          Object::RSpec::Core::Formatters::Helpers
        end

        # --------------------------------------------------------------------

        def dump_profile(profile)
          dump_profile_slowest_examples(profile)
          dump_profile_slowest_example_groups(
            profile
          )
        end

        # --------------------------------------------------------------------

        private
        def dump_profile_slowest_examples(profile)
          examples_header(profile)

          profile.slowest_examples.each do |e|
            sec = helpers.format_seconds(e.execution_result.run_time) + " seconds"

            @output.puts EXAMPLES % {
              :location => format_caller(e.location),
              :seconds => sec.to_f < 1 ? success_color(sec) : failure_color(sec),
              :description => e.full_description
            }
          end
        end

        # --------------------------------------------------------------------

        def dump_profile_slowest_example_groups(profile)
          groups_header(profile)

          profile.slowest_groups.each do |l, h|
            sec = helpers.format_seconds(h[:total_time]) + "seconds"

            @output.puts color_blue(GROUPS % {
              :description => h[:description],
              :total => sec.to_f < 2 ? success_color(sec) : failure_color(sec),
              :location => color_blue(strip_relative(l)),
              :count => h[:count]
            })
          end
        end

        # --------------------------------------------------------------------

        def groups_header(profile)
          @output.puts GROUPS_HEADER % {
            :size => profile.slowest_groups.size
          }
        end

        # --------------------------------------------------------------------

        def examples_header(profile)
          @output.puts EXAMPLES_HEADER % {
            :size => profile.slowest_examples.size,
            :seconds => helpers.format_seconds(profile.slow_duration),
            :per_cent => profile.percentage
          }
        end

        # --------------------------------------------------------------------

        def color_blue(str)
          Object::RSpec::Core::Formatters::ConsoleCodes.wrap(
            str, :cyan
          )
        end

        # --------------------------------------------------------------------

        def strip_relative(path)
          path.gsub(
            /\A\.\//, ""
          )
        end

        # --------------------------------------------------------------------

        def format_caller(caller_info)
          color_blue strip_relative(::RSpec.configuration.backtrace_formatter.backtrace_line(
            caller_info.to_s.split(':in `block').first
          ))
        end
      end
    end
  end
end
