require 'rails_helper'

describe ListHelper do
  describe '#list_button' do
    context 'user' do
      let(:staff) { create(:staff) }
      let(:edit_button) { helper.list_button(name: 'Edit', action: :edit, admin: :admin, resource: staff) }
      let(:delete_button) { helper.list_button(name: 'Delete', action: :delete, admin: :admin, resource: staff) }

      it 'returns edit button' do
        expect(edit_button).to include 'Edit'
        expect(edit_button).to include edit_admin_staff_path(staff.id)
        expect(edit_button).to include 'data-test="edit-staff-' + staff.id.to_s + '"'
      end

      it 'returns delete button' do
        expect(delete_button).to include 'Delete'
        expect(delete_button).to include admin_staff_path(staff.id)
        expect(delete_button).to include 'data-test="delete-staff-' + staff.id.to_s + '"'
        expect(delete_button).to include 'data-method="delete"'
        expect(delete_button).to include 'data-confirm="Confirm delete this staff?"'
      end
    end

    context 'leave' do
      let(:leave) { create(:leave) }
      let(:edit_button) { helper.list_button(name: 'Edit', action: :edit, admin: :admin, resource: leave) }
      let(:delete_button) { helper.list_button(name: 'Delete', action: :delete, admin: :admin, resource: leave) }

      it 'returns edit button' do
        expect(edit_button).to include 'Edit'
        expect(edit_button).to include edit_admin_leave_path(leave.id)
        expect(edit_button).to include 'data-test="edit-leave-' + leave.id.to_s + '"'
      end

      it 'returns delete button' do
        expect(delete_button).to include 'Delete'
        expect(delete_button).to include admin_leave_path(leave.id)
        expect(delete_button).to include 'data-test="delete-leave-' + leave.id.to_s + '"'
        expect(delete_button).to include 'data-method="delete"'
        expect(delete_button).to include 'data-confirm="Confirm delete this leave?"'
      end
    end

    context 'late' do
      let(:late) { create(:late) }
      let(:edit_button) { helper.list_button(name: 'Edit', action: :edit, admin: :admin, resource: late) }
      let(:delete_button) { helper.list_button(name: 'Delete', action: :delete, admin: :admin, resource: late) }

      it 'returns edit button' do
        expect(edit_button).to include 'Edit'
        expect(edit_button).to include edit_admin_late_path(late.id)
        expect(edit_button).to include 'data-test="edit-late-' + late.id.to_s + '"'
      end

      it 'returns delete button' do
        expect(delete_button).to include 'Delete'
        expect(delete_button).to include admin_late_path(late.id)
        expect(delete_button).to include 'data-test="delete-late-' + late.id.to_s + '"'
        expect(delete_button).to include 'data-method="delete"'
        expect(delete_button).to include 'data-confirm="Confirm delete this late?"'
      end
    end
  end
end
