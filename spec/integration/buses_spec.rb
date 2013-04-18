require 'spec_helper'

feature 'View buses', js: true do
  scenario 'lists student names' do
    pending 'ssl redirect issues'
    assignments = [
      bus_assignments_response(
        BusNumber: '1',
        StudentNo: '123',
        parentfirstname: 'Ned',
        parentlastname: 'Stark',
        studentfirstname: 'Aria',
        studentlastname: 'Stark'
      ),
      bus_assignments_response(
        BusNumber: '2',
        StudentNo: '456',
        parentfirstname: 'Ned',
        parentlastname: 'Stark',
        studentfirstname: 'Sansa',
        studentlastname: 'Stark'
      )
    ]

    bus_one_location = bus_location_response(
      bus_id: '1',
      latitude: 42.01,
      longitude: -71.01
    )

    bus_two_location = bus_location_response(
      bus_id: '2',
      latitude: 42.02,
      longitude: -71.02
    )

    stub_assignments_api [200, {}, assignments.to_json]
    stub_zonar_api [200, {}, bus_one_location]
    stub_zonar_api [200, {}, bus_two_location]

    sign_in student_number: '123'

    current_path.should eq buses_path

    selected_student('Aria Stark').click

    within student_names_list do
      student_element('Sansa Stark').click
    end

    page.should have_selected_student 'Sansa Stark'
  end
end
