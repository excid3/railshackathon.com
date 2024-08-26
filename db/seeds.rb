# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Event.find_or_initialize_by(
  theme: "Hotwire",
  title: "Hotwire",
).update!(
  start_time: DateTime.parse("2022-09-16 19:00:00 CDT"),
  end_time: DateTime.parse("2022-09-18 19:00:00 CDT"),
  published: true,
  start_time_link: "https://everytimezone.com/s/c64db7ce"
)

Event.find_or_initialize_by(
  theme: "Supporting the Ruby on Rails Community",
  title: "Supporting Rails",
).update!(
  start_time: DateTime.parse("2023-07-28 19:00:00 CDT"),
  end_time: DateTime.parse("2023-07-30 19:00:00 CDT"),
  published: true,
  start_time_link: "https://everytimezone.com/s/47d3a89a"
)

Event.find_or_initialize_by(
  theme: "Open Hackathon 2024",
  title: "Open Hackathon 2024"
).update!(
  start_time: DateTime.parse("2024-10-25 19:00:00 CDT"),
  end_time: DateTime.parse("2024-10-27 19:00:00 CDT"),
  published: true,
  start_time_link: "https://everytimezone.com/s/2cdcb58f"
)
