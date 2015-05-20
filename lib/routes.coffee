Router.configure
  layoutTemplate: "layout"

Router.route '/',
  name: 'home' 
  action: ->
    if Meteor.user()
      @render 'home'
    else
      @render 'signIn'

Router.route '/account',
  name: 'account'
  action: ->
    @render 'account'

Router.route '/contacts',
  name: 'contacts'
  action: ->
    @render 'contacts'

Router.route '/contacts/:contactid',
  name: 'contact'
  data: ->
    Contacts.findOne _id: @params.contactid
  action: ->
    @render 'contact'

requireLogin = ->
  if !Meteor.user()
    if Meteor.loggingIn()
      @render 'loading'
    else
      @render 'signIn'
  else
    @next()

Router.route '/signout',
  name: 'signOut'
  action: ->
    Meteor.logout ->
      Router.go '/'