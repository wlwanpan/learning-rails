require 'clockwork'
require './config/boot'
require './config/environment'

include Clockwork

class Scheduler

  def self.update_subber_statistics

    Subber.order("created_at DESC").all.each do |subber|

      fake_stat_api = [
        {data_title: "fake_stuff0", user_count: rand(0..9), date: rand(99..9999)},
        {data_title: "fake_stuff1", user_count: rand(0..99), date: rand(99..999)},
        {data_title: "fake_stuff2", user_count: rand(0..200), date: rand(99..999)},
        {data_title: "fake_stuff3", user_count: rand(0..200), date: rand(99..999)},
        {data_title: "fake_stuff4", user_count: rand(0..200), date: rand(99..999)}
      ]

      fake_stat_api.each do |stat|
        subber.statistics.build stat
      end
      puts "job done" if subber.save

    end
  end

end

module Clockwork

  handler do |job|

    puts "Running #{job}"
    Scheduler.public_send job
  end

  every 10.seconds, :update_subber_statistics

end
