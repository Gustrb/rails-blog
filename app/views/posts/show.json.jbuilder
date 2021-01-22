json.title @post.title
json.description @post.description

json.comments @comments do |comment|
  json.set! :id, comment.id
  json.set! :text, comment.text
end

json.tags @ordered_tags do |tag|
  json.set! :id, tag.id
  json.set! :name, tag.name
end
