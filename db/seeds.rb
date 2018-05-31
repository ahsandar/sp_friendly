User.create!([
  {email: "andy@example.com"},
  {email: "common@example.com"},
  {email: "john@example.com"},
  {email: "johnny@example.com"},
  {email: "lisa@example.com"},
  {email: "john123@example.com"},
  {email: "johnny123@example.com"},
  {email: "johnny456@example.com"},
  {email: "andy123@example.com"},

])

Friendship.create!([
  {person_id: 1, friend_id: 2},
  {person_id: 1, friend_id: 3},
  {person_id: 2, friend_id: 3},
  {person_id: 2, friend_id: 4},
  {person_id: 3, friend_id: 4},
  {person_id: 7, friend_id: 4},
  {person_id: 7, friend_id: 8},
  {person_id: 7, friend_id: 9}
])
Subscription.create!([
  {requestor_id: 6, target_id: 3},
  {requestor_id: 1, target_id: 3},
  {requestor_id: 9, target_id: 3}
])
