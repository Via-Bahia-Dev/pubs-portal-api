class CreatePublicationRequestsTemplates < ActiveRecord::Migration
  def change
    create_table :publication_requests_templates do |t|
    	t.belongs_to :publication_request, index: true
    	t.belongs_to :template, index: true
    end
  end
end
