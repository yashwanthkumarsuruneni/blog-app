class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         Roles = [ :admin , :default ]

  def is?( requested_role )
    self.role == requested_role.to_s
  end
  has_many :articles,dependent: :destroy
  has_many :comments,dependent: :destroy

end
