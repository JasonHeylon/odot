require "rails_helper"



describe "Create todo lists" do

	def create_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:description] ||= "This is my todo list."

		visit "/todo_lists"
		click_link "New Todo list"
		
		expect(page).to have_content("New todo_list") 

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end


	it "redirects to todo list index page on success" do
  		create_todo_list

		expect(page).to have_content("My todo list") 

	end

	it "display an error when the todo list has no title" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: ""

		expect(page).to have_content("error") 
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'am doing tody.")

	end


	it "display an error when the todo list has a title with less than 3 characters" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: "Hi"

		expect(page).to have_content("error") 
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'am doing tody.")

	end


	it "display an error when the todo list has no description" do
		expect(TodoList.count).to eq(0)

		create_todo_list description: ""

		expect(page).to have_content("error") 
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'am doing tody.")

	end

	it "display an error when the todo list has a description with less than 5 characters" do
		expect(TodoList.count).to eq(0)

		create_todo_list description: "Test"


		expect(page).to have_content("error") 
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'am doing tody.")

	end


end