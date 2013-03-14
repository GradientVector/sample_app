require 'spec_helper'

describe "UserPages" do

	subject { page }
	
	describe "signup page" do
		before { visit signup_path }
		
		it { should have_title("Sign up") }
		it { should have_header("Sign up") }
	end
	
	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		
		before { visit user_path(user) }
		
		it { should have_title(user.name) }
		it { should have_header(user.name) }
		
		describe "on navigation after initial submission" do
			it { should_not have_success_message("Welcome to the Sample App!") }
		end
	end
	
	describe "signup" do
		before { visit signup_path }
		
		let(:submit) { "Create my account" }
		
		describe "with invalid information" do
		
			describe "after submission" do
				before { click_button submit }
				
				it { should have_title("Sign up") }
				it { should have_content("error") }
			end
			
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end
		
		describe "with valid information" do
			let(:user) { FactoryGirl.build(:user) }
		
			before { provide_valid_signup_information(user) }
		
			it "should create a new user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
			
			describe "after saving the user" do
				before { click_button submit }
			
				it { should have_title(user.name) }
				it { should have_success_message("Welcome to the Sample App!") }
				it { should have_selector("img", alt: user.name, class: "gravatar") }
				it { should have_link("Sign out") }
			end
		end
	end
end
