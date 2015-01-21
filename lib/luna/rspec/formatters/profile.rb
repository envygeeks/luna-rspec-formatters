# This is exactly the same as RSpec except I removed a lot of the "\n" cruft.

module Luna
  module RSpec
    module Formatters
      module Profile
        def helpers
          ::RSpec::Core::Formatters::Helpers
        end

        def dump_profile(profile)
          dump_profile_slowest_examples(profile)
          dump_profile_slowest_example_groups(profile)
        end

        private
        def dump_profile_slowest_examples(profile)
          size = profile.slowest_examples.size
          seconds = helpers.format_seconds(profile.slow_duration)
          per_cent = profile.percentage

          @output.puts "\nTop #{size} slowest examples (#{seconds}s), " \
            "#{per_cent}% of total time):\n"

          profile.slowest_examples.each do |e|
            location = format_caller(e.location)
            seconds  = helpers.format_seconds(e.execution_result.run_time)
            @output.puts "  #{e.full_description} " \
              "#{bold(seconds)} #{bold("seconds")} #{location}"
          end
        end

        def dump_profile_slowest_example_groups(profile)
          return if profile.slowest_groups.empty?
          @output.puts "\nTop #{profile.slowest_groups.size} " \
            "slowest example groups:"

          profile.slowest_groups.each do |l, h|
            total = "#{helpers.format_seconds(h[:total_time])} seconds"
            average = "#{bold(helpers.format_seconds(h[:average]))} #{bold("seconds")} average"
            count = helpers.pluralize(h[:count], "example")

            @output.puts "  #{h[:description]} #{average} (#{total} / #{count}) #{l}"
          end
        end

        def bold(text)
          ::RSpec::Core::Formatters::ConsoleCodes.wrap(text, :bold)
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
