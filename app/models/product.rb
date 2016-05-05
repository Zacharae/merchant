class Product < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category

  has_attached_file :avatar, 
  	:styles => { 
  		:medium => "400x400#", :thumb => "150x150>"}, 
  	:default_url => "images/:style/missing.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
	validates_attachment_size :avatar, :less_than => 5.megabytes

  validates :name, presence: true, length: {minimum: 2} 
end
