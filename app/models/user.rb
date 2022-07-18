class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :timeoutable, :validatable
  audited

  def logs
    logs = Audited::Audit.where(user_id: id)
  end
end
