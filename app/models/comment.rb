class Comment < ActiveRecord::Base
  belongs_to :target, polymorphic: true
  belongs_to :author, polymorphic: true
  validates :body, presence: true
  delegate :name, to: :author, prefix: true, allow_nil: true

  def as_json(*)
    super.merge author_name: author_name
  end

  include Pusher::CommentCallbacks
end
