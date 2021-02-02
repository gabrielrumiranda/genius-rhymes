json.extract! @syllable,
  :id,
  :author_id,
  :start_index,
  :end_index,
  :body,
  :rhyme_id,
  :updated_at

json.author @syllable.author.username