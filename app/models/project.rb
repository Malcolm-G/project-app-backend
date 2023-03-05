class Project < ActiveRecord::Base
    has_many :jobs
    has_many :users, through: :jobs
    belongs_to :primary_user, class_name: 'User', foreign_key: 'project_owner_id'

    enum status:[ :CREATED, :ONGOING, :COMPLETED, :CANCELLED ]

    def project_owner
        User.find(project_owner_id)
    end
end