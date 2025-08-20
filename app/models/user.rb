class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  belongs_to :organisation
  enum role: { admin: "admin", reporter: "reporter" }

  attr_accessor :organisation_name

  after_create :create_organisation_for_admin

  private

  def create_organisation_for_admin
    return unless admin? && organisation.nil? && organisation_name.present?
    self.organisation = Organisation.create!(name: organisation_name)
    save!
  end
end
