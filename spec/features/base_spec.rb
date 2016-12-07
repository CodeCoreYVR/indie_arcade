require 'rails_helper'

describe 'visiting the homepage', type: :feature do
  it 'loads the homepage' do
    visit '/'
    expect(page).to have_content 'Create Account'
    expect(page).to have_content 'Find an arcade near you'
  end
end

describe 'the login process', type: :feature do
  let(:user) { FactoryGirl.create :user }

  it 'loads the login page' do
    visit '/sessions/new'
    expect(page).to have_content 'Create Account'
    expect(page).to have_css 'div.container.login-user'
  end

  it 'logs in successfully' do
    visit '/sessions/new'
    within('#session-form', match: :first) do
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button 'Login'
    end
    expect(page).to have_content 'My Profile'
    expect(page).to have_content user.company
  end

  it 'logs in unsuccessfully' do
    visit '/sessions/new'
    within('#session-form', match: :first) do
      fill_in 'email', with: user.email
      click_button 'Login'
    end
    expect(page).to have_content 'Create Account'
    expect(page).to have_content 'Remember me'
  end
end

describe 'the signup process', type: :feature do
  let(:user) { FactoryGirl.build :user }

  it 'loads the sign up page' do
    visit '/users/new'
    expect(page).to have_content 'New User'
    expect(page).to have_content 'Already have an account?'
    expect(page).to have_css 'div.create-user'
  end

  it 'signs up successfully' do
    visit '/users/new'
    within('div.register-form-control', match: :first) do
      fill_in 'user[company]', with: user.company
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: user.password
    end
    click_button 'Signup'
    expect(page).to have_content 'My Profile'
    expect(page).to have_content user.company
  end

  it 'signs up unsuccessfully' do
    visit '/users/new'
    within('div.register-form-control', match: :first) do
      fill_in 'user[company]', with: user.company
    end
    click_button 'Signup'
    expect(page).to have_content "can't be blank"
    expect(page).to have_css 'div.create-user'
  end
end
