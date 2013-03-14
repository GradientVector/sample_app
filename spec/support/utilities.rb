include ApplicationHelper

# def full_title(page_title)
	# base_title = "Ruby on Rails Tutorial Sample App"
	# if page_title.empty?
		# base_title
	# else
		# "#{base_title} | #{page_title}"
	# end
# end

def provide_valid_signup_information(user)
	fill_in "Name", with: user.name
	fill_in "Email", with: user.email
	fill_in "Password", with: user.password
	fill_in "Confirmation", with: user.password
end

def valid_signin(user)
	fill_in "Email", with: user.email.upcase
	fill_in "Password", with: user.password
	click_button "Sign in"
end

RSpec::Matchers.define :have_header do |header|
	match do |page|
		page.should have_selector('h1', text: header)
	end
end

RSpec::Matchers.define :have_title do |title|
	match do |page|
		page.should have_selector('title', text: title)
	end
end

RSpec::Matchers.define :have_success_message do |message|
	match do |page|
		page.should have_selector("div.alert.alert-success", text: message)
	end
end

RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		page.should have_selector("div.alert.alert-error", text: message)
	end
end