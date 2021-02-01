class Rhyme < ActiveRecord::Base
  validates :song,
            :author,
            :color,
            :body,
            presence: true

  belongs_to :song
  belongs_to :author,
              foreign_key: :author_id,
              primary_key: :id,
              class_name: :User

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :upvotable, dependent: :destroy
  has_many :syllables, as: :syllableable, dependent: :destroy
end
