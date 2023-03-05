# frozen_string_literal: true

class User < ActiveRecord::Base

  has_many :jobs
  has_many :projects, through: :jobs
  has_many :own_projects, class_name: 'Project', foreign_key: 'project_owner_id'

  # table consists of password_hash as a column to store password hashes in DB
  include BCrypt

  # retrieve password from hash
  def password
    @password ||= Password.new(password_hash)
  end

  # create the password hash
  def password=(new_pass)
    @password = Password.create(new_pass)
    self.password_hash = @password
  end

end