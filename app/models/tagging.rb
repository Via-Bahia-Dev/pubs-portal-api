class Tagging < ActiveRecord::Base
  belongs_to :template
  belongs_to :tag

  validates_presence_of :template_id, :tag_id
end
