requireLogin = ->
  if !Meteor.user()
    if Meteor.loggingIn()
      @render 'loading'
    else
      @render 'signIn'
  else
    @next()

Router.configure
  layoutTemplate: "layout"

Router.onBeforeAction requireLogin,
  except: ['home']

Router.route '/',
  name: 'home' 
  action: ->
    if Meteor.user()
      @render 'contacts'
    else
      @render 'signIn'

Router.route '/signout',
  name: 'signOut'
  action: ->
    Meteor.logout ->
      Router.go '/'