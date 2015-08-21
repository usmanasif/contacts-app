require 'test_helper'

class ContactTest < ActiveSupport::TestCase

  test 'should not save contact without first name' do
    john = contacts(:john)
    john.first_name = nil
    assert_not john.save
  end


  test 'should not save contact without last name' do
    john = contacts(:john)
    john.last_name = nil
    assert_not john.save
  end


  test 'should not save contact without phone' do
    john = contacts(:john)
    john.phone = nil
    assert_not john.save
  end


  test 'should not save contact invalid phone' do
    john = contacts(:john)
    john.phone = '+1321321abc'
    assert_not john.save
  end


  test 'should not save contact without email' do
    john = contacts(:john)
    john.email = nil
    assert_not john.save
  end


  test 'should not save contact with invalid email' do
    john = contacts(:john)
    john.email = 'xyz'
    assert_not john.save
  end
end
