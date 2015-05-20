Meteor.startup ->
  Meteor.users.remove({})
  if !Meteor.users.findOne(username: 'Default')
    Accounts.createUser
      email: 'test@icentris.com'
      username: 'Default'
      password: '3nj0y'