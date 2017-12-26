json.array! @events do |event|
  json.id event["id"]
  json.type event["type"]
  json.actor do
    actor = event["actor"]
    json.id actor["id"]
    json.login actor["login"]
    json.display_login actor["display_login"]
    json.gravatar_id actor["gravatar_id"]
    json.url actor["url"]
    json.avatar_url actor["avatar_url"]
  end
  json.created_at event["created_at"]
end
