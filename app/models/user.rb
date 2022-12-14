# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  unlock_token           :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
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
