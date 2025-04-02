class TestJob < ApplicationJob
  queue_as :default

  def perform(mensaje)
    puts mensaje
  end
end