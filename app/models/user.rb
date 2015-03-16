class User < ActiveRecord::Base
  has_secure_password
  validates :email, :name, presence: true, uniqueness: true 
  validates_inclusion_of :age, in: 10..100
  validates :password, presence: true 
  has_many :posts
  has_attached_file :profile_picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
  :default_url => "app/assets/images/missing.png", 
  :path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:filename" 
  validates_attachment_content_type :profile_picture, :content_type => /\Aimage\/.*\Z/

end
