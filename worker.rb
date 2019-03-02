#!/usr/bin/env ruby
require 'bunny'
connection = Bunny.new
connection.start

channel = connection.create_channel
queue = channel.queue('hello')

begin
  puts ' [*] Waiting for messages. To exit press CTRL+C'
  queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, body|
  puts " [x] Received #{body}"
  # imitate some work
  sleep body.count('.').to_i
  puts ' [x] Done'
end
rescue Interrupt => _
  connection.close
  channel.ack(delivery_info.delivery_tag)
  exit(0)
end



