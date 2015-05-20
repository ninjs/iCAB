Template.signIn.events
  'submit .form-signin': (e, t) ->
    e.preventDefault()
    email = t.find('#email').value.toLowerCase()
    password = t.find('#password').value

    Meteor.loginWithPassword email, password, (error) ->
      if error
        toastr.warning(error.reason)
      else
        Router.go "home"