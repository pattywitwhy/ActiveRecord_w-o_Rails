require 'sqlite3'
require 'active_record'

# Set up a database that resides in RAM
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Set up database tables and columns
ActiveRecord::Schema.define do
  create_table :students, force: true do |t|
    t.string :name
  end
  
  create_table :tutors, force: true do |t|
    t.string :title
  end

  create_join_table :student, :tutor, table_name: :klasses do |t|
    t.index :student_id
    t.index :tutor_id
  end
end

# Set up model klasses
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Student < ApplicationRecord
  has_many :klasses
  has_many :tutors, through: :klasses
end

class Klass < ApplicationRecord
  belongs_to :student
  belongs_to :tutor
end

class Tutor < ApplicationRecord
  has_many :klasses
  has_many :students, through: :klasses
end