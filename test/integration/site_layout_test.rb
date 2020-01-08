require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  test 'layout_links for non-logged user' do
    get root_path

    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path

    get contact_path
    assert_select "title", full_title("Contact")

    get signup_path
    assert_select "title", full_title("Sign up")
  end

  test 'layout links for an logged user' do
    @user = users(:archer)
    log_in_as(@user)

    get root_path
    
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count:2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path

    get users_path
    assert_select "title", full_title("All users")
  end
end
