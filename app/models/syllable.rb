class Syllable < ActiveRecord::Base
  validates :rhyme,
            :author,
            :start_index,
            :end_index,
            :body,
            presence: true

  belongs_to :rhyme
  belongs_to :commentable
  belongs_to :author,
              foreign_key: :author_id,
              primary_key: :id,
              class_name: :User
end
