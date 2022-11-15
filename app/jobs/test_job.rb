class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "TestJob: #{args}"
  end
end
