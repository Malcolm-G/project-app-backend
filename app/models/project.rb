class Project < ActiveRecord::Base
    has_many :jobs
    has_many :users, through: :jobs

    enum status:[ :CREATED, :ONGOING, :COMPLETED, :CANCELLED ]

    def project_owner
        User.find(project_owner_id)
    end
end