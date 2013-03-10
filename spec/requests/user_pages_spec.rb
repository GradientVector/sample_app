require 'spec_helper'

describe "UserPages" do

	subject { page }
	
	describe "signup page" do
		before { visit signup_path }
		
		it { should have_selector("h1",		text: "Sign up") }
		it { should have_selector("title", 	text: full_title("Sign up")) }
	end
	
	describe "profile page" do
		# Code to make a user variable
		let(:user) { FactoryGirl.create(:user) }
		
		before { visit user_path(user) }
		
		it { should have_selector('h1',		text: user.name) }
		it { should have_selector('title', 	text: user.name) }
		
		describe "on navigation after initial submission" do
			it { should_not have_selector("div.alert.alert-success", text: "Welcome to the Sample App!") }
		end
	end
	
	describe "signup" do
		before { visit signup_path }
		
		let(:submit) { "Create my account" }
		
		describe "with invalid information" do
		
			describe "after submission" do
				before { click_button submit }
				
				it { should have_selector("title", text: "Sign up") }
				it { should have_content("error") }
			end
			
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end
		
		describe "with valid information" do
			let(:name) { "Example User" }
			let(:email) { "user@example.com" }
			let(:password) { "foobar" }
		
			before do
				fill_in "Name", with: name
				fill_in "Email", with: email
				fill_in "Password", with: password
				fill_in "Confirmation", with: password
			end
			
			describe "after saving the user" do
				before { click_button submit }
				
				let(:user) { User.find_by_email(email) }
				
				it { should have_selector("title", text: name) }
				it { should have_selector("div.alert.alert-success", text: "Welcome to the Sample App!") }
				it { should have_selector("img", alt: name, class: "gravatar") }
			end
			
			it "should create a new user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end
	end
end
