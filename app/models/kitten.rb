class Kitten < ActiveRecord::Base
    extend DeprecatedAlias
  
    #include Kitten::ProjectSharing
  
    after_update :update_issues_from_sharing_change, if: :saved_change_to_sharing?
    belongs_to :project
    has_many :fixed_issues, class_name: 'WorkPackage', foreign_key: 'kitten_id', dependent: :nullify
    has_many :work_packages, foreign_key: :kitten_id
    acts_as_customizable
  
  
end
  