class CourierJob < ApplicationJob
  include Jets::AwsServices
  class_timeout 30
  depends_on :list

  iam_policy("sns", "dynamodb")
  sqs_event ref(:waitlist)
  def process
    # Jets.logger.info("CourierJob event: #{event}")
    Jets.logger.info("CourierJob sqs_events: #{sqs_events}")

    sqs_events.each do |payload|
      process_message(payload)
    end

    # topic_arn = Alert.lookup(:delivery_completed) # looks up output from the Alert cfn stack
    # sns.publish(
    #   topic_arn: topic_arn,
    #   subject: "CourierJob processed",
    #   message: "Test sqs_events #{sqs_events}"
    # )
  end

private
  def process_message(payload)
    puts "process_message #{payload.inspect}"
    test_message = payload["test"] || payload # test key value or entire payload
    Jets.logger.info("CourierJob test_message: #{test_message}")

    delivery = Delivery.create!(message: test_message)
    puts "delivery #{delivery.inspect}"
  end
end
