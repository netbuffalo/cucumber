module Cucumber
  module Filters

    # Batches up all test cases, randomizes them, and then sends them on
    class Randomizer
      def initialize(seed, receiver)
        @receiver = receiver
        @test_cases = []
        @seed = seed
      end

      def test_case(test_case)
        @test_cases << test_case
        self
      end

      def done
        shuffled_test_cases.each do |test_case|
          test_case.describe_to(@receiver)
        end
        @receiver.done
        self
      end

      private

      def shuffled_test_cases
        @test_cases.shuffle(random: Random.new(seed))
      end

      attr_reader :seed
      private :seed
    end

  end
end
