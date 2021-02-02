json.extract! @rhyme,
  :id,
  :author_id,
  :song_id,
  :body,
  :color,
  :updated_at

rhyme.author @rhyme.author.username

json.set! :votes do
  @rhyme.votes.each do |vote|
    json.set! vote.user_id, vote
  end
end

json.comments @rhyme.comments do |comment|
  json.partial! "/api/comments/comment", comment: comment
end
