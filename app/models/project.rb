class Project < ActiveRecord::Base
    has_many :jobs
    has_many :users, through: :jobs

    enum :status, [ :ERROR, :CREATED, :ONGOING, :COMPLETED, :CANCELLED ]
end