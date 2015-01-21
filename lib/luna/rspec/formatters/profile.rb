module Luna
  module RSpec
    module Formatters
      module Profile
        EXAMPLES = "  %{description} %{seconds} seconds: %{location}"
          GROUPS = "  %{description} %{total} seconds over %{count} examples: %{location}"
        EXAMPLES_HEADER = "\nTop %{size} slowest examples (%{seconds}s), %{per_cent}%% of total time:\n"
          GROUPS_HEADER = "\nTop %{size} slowest example groups:"


        def helpers
          ::RSpec::Core::Formatters::Helpers
        end

        def dump_profile(profile)
          dump_profile_slowest_examples(profile)
          dump_profile_slowest_example_groups(profile)
        end

        private
        def dump_profile_slowest_examples(profile)
          unless profile.slowest_examples.any? { |e| e.execution_result.run_time >= 0.2 }
            return
          end

          examples_header(profile)
          profile.slowest_examples.each do |e|
            @output.puts EXAMPLES % {
              location: format_caller(e.location),
              seconds: failure_color(helpers.format_seconds(e.execution_result.run_time)),
              description: e.full_description
            }
          end
        end

        def dump_profile_slowest_example_groups(profile)
          unless !profile.slowest_groups.empty? && \
              profile.slowest_groups.any? { |l, h| h[:average] >= 0.4 }

            return
          end

          groups_header(profile)
          profile.slowest_groups.each do |l, h|
            @output.puts GROUPS % {
              description: h[:description],
              total: failure_color(helpers.format_seconds(h[:total_time])),
              count: helpers.pluralize(h[:count], "example"),
              location: l
            }
          end
        end

        def groups_header(profile)
          @output.puts GROUPS_HEADER % {
            size: profile.slowest_groups.size
          }
        end

        def examples_header(profile)
          @output.puts EXAMPLES_HEADER % {
            size: profile.slowest_examples.size,
            seconds: helpers.format_seconds(profile.slow_duration),
            per_cent: profile.percentage
          }
        end

        def format_caller(caller_info)
          ::RSpec.configuration.backtrace_formatter.backtrace_line(
            caller_info.to_s.split(':in `block').first
          )
        end
      end
    end
  end
end
