#!/usr/bin/env ruby
require 'bunny'
connection = Bunny.new(automatically_recover: false)
connection.start
channel = connection.create_channel
queue = channel.queue('task_queue', durable: true)
# channel.default_exchange.publish('Hello World!', routing_key: queue.name)
# puts " [x] Sent 'Hello World!'"
message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')
queue.publish(message, persistent: true)
puts " [x] Sent #{message}"

connection.close
