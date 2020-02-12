require 'sqlite3'
require 'active_record'

# Set up a database that resides in RAM
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Set up database tables and columns
ActiveRecord::Schema.define do
  create_table :authors, force: true do |t|
    t.string :name

  end
  create_table :books, force: true do |t|
    t.string :title
    t.references :author
  end
end

# Set up model classes
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Author < ApplicationRecord
  has_many :books
end

class Book < ApplicationRecord
  belongs_to :authors
end