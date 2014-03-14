class AddSponsorAndLastEditorReferencesToStandardChanges < ActiveRecord::Migration
  def change
    add_reference :standard_changes, :sponsor, index: true
    add_reference :standard_changes, :last_editor, index: true
  end
end
