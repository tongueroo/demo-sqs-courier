class CourierJob < ApplicationJob
  include Jets::AwsServices
  class_timeout 30
  depends_on :list

  iam_policy("sns")
  sqs_event ref(:waitlist)
  def process
    # Jets.logger.info("CourierJob event: #{event}")
    Jets.logger.info("CourierJob sqs_event_payload: #{sqs_event_payload}")

    topic_arn = Alert.lookup(:delivery_completed) # looks up output from the Alert cfn stack
    sns.publish(
      topic_arn: topic_arn,
      subject: "CourierJob processed",
      message: "Test sqs_event_payload #{sqs_event_payload}"
    )
  end
end
