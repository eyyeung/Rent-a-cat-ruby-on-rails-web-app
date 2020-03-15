require 'date'

class Cat < ApplicationRecord
    COAT_COLOR=%w(black white tuxeto mixed orange ginger grey)

    validates :name, :user_id, :birth_date, :description, :sex, :color, presence: true
    validates :name, uniqueness: true
    validates :sex, inclusion: { in: ['F','M']}
    validates :sex, length: { is: 1}
    validates :color, inclusion: { in: COAT_COLOR}

    has_many :cat_rental_requests,
        class_name: :CatRentalRequests,
        primary_key: :id,
        foreign_key: :cat_id,
        dependent: :destroy

    belongs_to :owner,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id

    def age
        #substracting two time gives the difference in seconds, then divide by how many seconds is in a year and flooring it
        return age=((Time.now - birth_date.to_time)/1.year.seconds).floor
    end
end