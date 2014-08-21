require "rails_helper"



describe "Create todo lists" do
	it "redirects to todo list index page on success" do
  		visit "/todo_lists"
		click_link "New Todo list"
		
		expect(page).to have_content("New todo_list") 


		fill_in "Title", with: "My todo list"
		fill_in "Description", with: "This is what I'am doing today."
		click_button "Create Todo list"

		expect(page).to have_content("My todo list") 

	end

	it "display an error when the todo list has no title" do
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		
		expect(page).to have_content("New todo_list") 


		fill_in "Title", with: ""
		fill_in "Description", with: "This is what I'am doing today."
		click_button "Create Todo list"

		expect(page).to have_content("error") 
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'am doing tody.")

	end


	it "display an error when the todo list has a title with less than 3 characters" do
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		
		expect(page).to have_content("New todo_list") 


		fill_in "Title", with: "Hi"
		fill_in "Description", with: "This is what I'am doing today."
		click_button "Create Todo list"

		expect(page).to have_content("error") 
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'am doing tody.")

	end


	it "display an error when the todo list has no description" do
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		
		expect(page).to have_content("New todo_list") 


		fill_in "Title", with: "This is title"
		fill_in "Description", with: ""
		click_button "Create Todo list"

		expect(page).to have_content("error") 
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'am doing tody.")

	end

	it "display an error when the todo list has a description with less than 5 characters" do
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		
		expect(page).to have_content("New todo_list") 


		fill_in "Title", with: "This is title"
		fill_in "Description", with: "Test"
		click_button "Create Todo list"

		expect(page).to have_content("error") 
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'am doing tody.")

	end


end