require 'clockwork'
require './config/boot'
require './config/environment'

include Clockwork

def update_subber_statistics

  # fake_stat_api = [
  #   {data_title: "fake_stuff0", user_count: rand(0..9), date: rand(99..9999)},
  #   {data_title: "fake_stuff1", user_count: rand(0..99), date: rand(99..999)},
  #   {data_title: "fake_stuff2", user_count: rand(0..200), date: rand(99..999)},
  #   {data_title: "fake_stuff3", user_count: rand(0..200), date: rand(99..999)},
  #   {data_title: "fake_stuff4", user_count: rand(0..200), date: rand(99..999)}
  # ]
  # Subber.order("created_at DESC").all.each do |subber|
  #   fake_stat_api.each do |stat|
  #     subber.statistics.build(stat)
  #   end
  #   subber.save
  # end
end

module Clockwork

  handler do |job|

    puts "Running #{job}"

    fake_stat_api = [
      {data_title: "fake_stuff0", user_count: rand(0..9), date: rand(99..9999)},
      {data_title: "fake_stuff1", user_count: rand(0..99), date: rand(99..999)},
      {data_title: "fake_stuff2", user_count: rand(0..200), date: rand(99..999)},
      {data_title: "fake_stuff3", user_count: rand(0..200), date: rand(99..999)},
      {data_title: "fake_stuff4", user_count: rand(0..200), date: rand(99..999)}
    ]
    Subber.order("created_at DESC").all.each do |subber|
      fake_stat_api.each do |stat|
        subber.statistics.build(stat)
      end
      subber.save
    end

    puts Statistic.all.length

  end

  every 10.seconds, 'update_subber_statistics'

end
