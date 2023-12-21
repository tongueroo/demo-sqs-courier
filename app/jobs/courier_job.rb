class CourierJob < ApplicationJob
  class_timeout 30
  depends_on :list
  sqs_event ref(:waitlist)
  def process
    # Jets.logger.info("CourierJob event: #{event}")
    Jets.logger.info("CourierJob sqs_event_payload: #{sqs_event_payload}")
  end
end
