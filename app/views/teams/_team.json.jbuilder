json.extract! team, :id, :name, :description, :created_at, :updated_at
json.url team_url(team, format: :json)
json.description team.description.to_s
