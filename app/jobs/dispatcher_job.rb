class DispatcherJob < ApplicationJob
  include Jets::AwsServices

  iam_policy 'sqs'
  def dispatch
    Jets.logger.info("Dispatched from job: #{event}")
    queue_url = List.lookup(:waitlist_url)
    message_body = JSON.dump(event)
    sqs.send_message(queue_url:, message_body:)
    Jets.logger.info("Sent message to queue: #{queue_url}")
  end

  def self.dispatch_with_threads(n=10)
    threads = []
    n.times do |i|
      threads << Thread.new do
        perform_now(:dispatch, {test: "message #{i+1}"})
      end
    end
    threads.each(&:join)
  end
end
