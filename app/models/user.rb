class User < ApplicationRecord
  has_many :boards, dependent: :destroy
  has_one :profile, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def has_written?(board)
    boards.exists?(id: board.id)
  end

  def display_name
    # if profile && profile.nickname
    #   profile.nickname
    # else
    #   self.email.split('@').first
    # end

    profile&.name || self.email.split('@').first

  end
end