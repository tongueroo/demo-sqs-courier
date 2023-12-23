# Jets Project to Debug SQS Queue Messages

Overview

    DispatcherJob => SQS Queue => CourierJob => Processing

Deploy stack

    jets deploy

## Testing

While tailing logs in one terminal, we're going to test with console in another.

    jets logs -f -n courier_job-process

Test deployed app with console

    jets console

Ruby IRB snippet

```ruby
5.times { |i| DispatcherJob.perform_now(:dispatch, test: "message #{i+1}") }

10.times { |i| Thread.new { DispatcherJob.perform_now(:dispatch, test: "message #{i+1}") } }

10.times { |i| Thread.new { CourierJob.perform_now(:process, test: "message #{i+1}") } }
```

Session Output

    ❯ jets console
    Jets booting up in development mode!
    irb(main):001:0> 5.times { |i| DispatcherJob.perform_now(:dispatch, test: "message #{i+1}") }
    Dispatched from job: {"test"=>"message 1"}
    Dispatched from job: {"test"=>"message 2"}
    Dispatched from job: {"test"=>"message 3"}
    Dispatched from job: {"test"=>"message 4"}
    Dispatched from job: {"test"=>"message 5"}
    => 5
    irb(main):002:0>

Tail with a grep test

    ❯ jets logs -f -n courier_job-process | grep test
    Tailing logs for /aws/lambda/testapp-dev-courier_job-process
    2023-12-21 15:18:56 UTC CourierJob sqs_event_payload: {"test"=>"message 1"}
    2023-12-21 15:18:56 UTC CourierJob sqs_event_payload: {"test"=>"message 2"}
    2023-12-21 15:18:56 UTC CourierJob sqs_event_payload: {"test"=>"message 3"}
    2023-12-21 15:18:56 UTC CourierJob sqs_event_payload: {"test"=>"message 4"}
    2023-12-21 15:18:56 UTC CourierJob sqs_event_payload: {"test"=>"message 5"}

Note: There's also a `DispatcherJob.dispatch_with_threads` for testing.

## Tested with 1000 Threads

Tested with 1000 Threads after the fixes.

    irb(main):001:0> DispatcherJob.dispatch_with_threads(1000)
    irb(main):002:0> Message.count
    => 1000
    irb(main):003:0> Delivery.count
    => 1000
    irb(main):004:0>

Exactly 1,000 DynamoDB Items and 1,000 ActiveRecord Records were saved.

This confirms that the fixes work.
