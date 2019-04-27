loop do
  print `bundle exec ruby cli.rb -w /app/data/database.jsonl`
  sleep 5 * 60
end
