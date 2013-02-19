class Debt < ActiveRecord::Base
  belongs_to :debitor, :class_name => "User", :foreign_key => 'debitor_id'
  belongs_to :creditor, :class_name => "User", :foreign_key => 'creditor_id'
      attr_accessible :bill,:bill_file_name,:bill_content_type,:bill_file_size,:bill_updated_at,:cleared, :creditor_id, :debitor_id, :description, :value, :confirmed

  has_attached_file :bill, :storage => :dropbox,:dropbox_credentials => "#{Rails.root}/config/dropbox.yml",:dropbox_options => {:unique_filename => true}

  validates :debitor_id,:value, :presence => true
  validates_attachment :bill, :content_type => { :content_type => ["image/jpg","image/png","image/jpeg","application/pdf"] },
  :size => { :in => 0..500.kilobytes }
end
