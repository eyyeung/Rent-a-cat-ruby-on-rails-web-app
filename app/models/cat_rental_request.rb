class CatRentalRequest < ApplicationRecord
    STATUS= %w(PENDING APPROVED DENIED)
    validates :cat_id, :start_date, :end_date, :status, presence: true
    validates :status, inclusion: STATUS
    validate :does_not_overlap_approved_request

    belongs_to :cat,
        class_name: :Cat,
        primary_key: :id,
        foreign_key: :cat_id

    def overlapping_requests
        CatRentalRequest.where.not(id: self.id).where(cat_id: cat_id).where.not("start_date > :end_date OR end_date < :start_date",start_date: start_date, end_date: end_date)
    end

    def overlapping_approved_requests
       overlapping_requests.where("status= \'APPROVED\'") 
    end

    def overlapping_pending_requests
        overlapping_requests.where("status=\'PENDING\'")
    end

    def approve!
            self.status="APPROVED"
            self.save!
            overlapping_pending_requests.each do |request|
                request.deny!
            end
    end

    def deny!
        self.status="DENIED"
        self.save!
    end

    def pending?
        self.status=="PENDING"
    end

    def does_not_overlap_approved_request
        if (self.status=="APPROVED"||self.status=="PENDING") && overlapping_approved_requests.exists?
            errors[:base]<<'overlapping request'
        end
    end
end