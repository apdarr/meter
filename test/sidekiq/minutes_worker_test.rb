require 'test_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!
class MinutesWorkerTest < Minitest::Test
  def test_example
    skip "add some examples to (or delete) #{__FILE__}"
  end
end
