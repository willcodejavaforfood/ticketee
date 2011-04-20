class Permission < ActiveRecord::Base
  belongs_to :object, :polymorphic => true
  belongs_to :user
end
