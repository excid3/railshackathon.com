require "test_helper"

class VoteTest < ActiveSupport::TestCase
  test "users can only have a maximum of 5 vote" do
    user = users(:one)
    entry = entries(:six)

    new_vote = user.votes.build(entry: entry)
    refute new_vote.valid?
  end

  test "users can update their vote positions" do
    user = users(:one)
    vote = user.votes.first

    vote.position = 100
    assert vote.valid?
  end

  test "user can't vote for the same entry multiple times" do
    assert_raises do
      users(:two).votes.create!(entry: entries(:one))
      users(:two).votes.create!(entry: entries(:one))
    end
  end
end
