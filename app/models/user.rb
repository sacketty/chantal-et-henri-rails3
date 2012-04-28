class User < ActiveRecord::Base
  # attr_accessible :title, :body
  has_and_belongs_to_many :songs
  validates :last_name, :presence=>true
  validates :email, presence: true, uniqueness: true

  
  def self.from_auth(auth)
    args = [ 'email', 'name', 'nickname', 'first_name', 'last_name', 'image', 'location']
    attr={:uid=>auth['uid'], :provider=>auth['provider']}
    args.each do |arg|
      attr[arg.to_sym]=auth['info'][arg]
    end
    user=User.first(:email=>attr[:email])
    if user
      user.update_attributes(attr)
    end
    user
  end

end
