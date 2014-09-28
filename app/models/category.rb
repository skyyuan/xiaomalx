class Category < ActiveRecord::Base
  acts_as_nested_set :counter_cache => :children_count
  attr_protected :lft, :rgt
  has_many :questions
end
