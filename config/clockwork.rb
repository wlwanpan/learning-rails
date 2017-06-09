require 'clockwork'

fake_stat_api = [
  {data_title: "fake_stuff0", user_count: rand(9..99), date: rand(99..9999)},
  {data_title: "fake_stuff1", user_count: rand(99..999), date: rand(99..999)},
  {data_title: "fake_stuff2", user_count: rand(999..9999), date: rand(99..999)},
  {data_title: "fake_stuff3", user_count: rand(9999..99999), date: rand(99..999)},
  {data_title: "fake_stuff4", user_count: rand(99999..999999), date: rand(99..999)}
]


def update_subber_statistics
  puts "Statistics update called"
  # Check chain methods runtime (bad idea)
  Subber.order("created_at DESC").all.each do |subber|
    # call gregs api and set its appropriate data to statistics
    # ArgsToPass = [:key, :subber_name]
    fake_stat_api.each do |stat|
      subber.statistics.build stat
    end
  end
end

every 1.minute, 'update_subber_statistics'
