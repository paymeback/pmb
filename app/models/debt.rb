class Debt < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :debitor, :class_name => "User", :foreign_key => 'debitor_id'
  belongs_to :creditor, :class_name => "User", :foreign_key => 'creditor_id'
  alias_attribute :expiration_date,:ex_date
    attr_accessible :ex_date,:bill,:bill_file_name,:bill_content_type,:bill_file_size,:bill_updated_at,:cleared, :creditor_id, :debitor_id, :description, :value, :confirmed

  has_attached_file :bill, :storage => :dropbox,:dropbox_credentials => "#{Rails.root}/config/dropbox.yml",:dropbox_options => {:unique_filename => true}

  validates :debitor_id,:value,:description, :presence => true
  validates_attachment :bill, :content_type => { :content_type => ["image/jpg","image/png","image/jpeg","application/pdf"] },
  :size => { :in => 0..500.kilobytes }

  validates_with DateValidator
end
