Session.setDefault 'counter', 0
Template.layout.helpers 
  signedIn: ->
    Meteor.user()
Template.layout.events 'click button': ->
  Session.set 'counter', Session.get('counter') + 1