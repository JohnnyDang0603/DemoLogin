class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :timesheets, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  attr_writer :login

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    login = warden_conditions.to_h[:login]
    where('lower(username) = :value OR lower(email) = :value', value: login.downcase).first
    # conditions = warden_conditions.dup
    # if (login = conditions.delete(:login))
    #   byebug
    #   where(conditions.to_h).where('lower(username) = :value OR lower(email) = :value', { value: login.downcase }).first
    # elsif conditions.has_key?(:username) || conditions.has_key?(:email)
    #   where(conditions.to_h).first
    # end
  end

  def admin?
    has_role?(:admin)
  end
end
