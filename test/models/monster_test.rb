require 'test_helper'

class MonsterTest < ActiveSupport::TestCase
  
  test 'should have the necessary required validators' do
	monster = Monster.new
	assert_not monster.valid?
	assert_equal [:name, :power, :monster_type], monster.errors.keys
  end

  test 'should pass validations' do
    monster = Monster.new(name:'name', power:'power', monster_type: 'type')
	assert_equal monster.valid?, true
  end
end
