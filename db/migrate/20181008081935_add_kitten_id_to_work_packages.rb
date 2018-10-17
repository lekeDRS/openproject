class AddKittenIdToWorkPackages < ActiveRecord::Migration[5.1]
  def change
    add_reference :work_packages, :kitten 
  end
end
