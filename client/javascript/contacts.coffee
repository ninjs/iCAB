Session.setDefault 'isAdding', false
Session.setDefault 'isEditing', false
Session.setDefault 'isSearching', false
Session.setDefault 'activeContact', null

# ------- RENDERED ---------

Template.contacts.rendered = () ->
  Session.set 'isAdding', false
  Session.set 'isEditing', false
  Session.set 'isSearching', false
  Session.set 'activeContact', null

Template.addContact.rendered = () ->
  $(":input").inputmask();

Template.editContact.rendered = () ->
  $(":input").inputmask();


# ------ HELPERS --------

Template.activeContact.helpers
  contact: ->
    Contacts.findOne(Session.get 'activeContact')

Template.contactForm.helpers
  isAdding: ->
    Session.get 'isAdding'
  isEditing: ->
    Session.get 'isEditing'

Template.editContact.helpers
  contact: ->
    Contacts.findOne(Session.get 'activeContact')

Template.contacts.helpers
  isAdding: ->
    Session.get 'isAdding'
  isEditing: ->
    Session.get 'isEditing'
  isSearching: ->
    Session.get 'isSearching'
  contacts: ->
    Contacts.find({}, {sort: {favorite: -1, lastName: 1}})
  contact: ->
    Contacts.findOne(Session.get 'activeContact')
  searchResults: ->
    keyword = Session.get("search-query")
    query = new RegExp(keyword, 'i')
    results = Contacts.find($or: [
      { 'firstName': query }
      { 'lastName': query }
      { 'email': query }
      { 'phone': query }
    ], {sort: {favorite: -1, lastName: 1}})
    return {results: results}

# --------- EVENTS -------------

Template.addContact.events
  'click .submit': (e) ->
    e.preventDefault()
    form = $('.contact-form')
    inputs = form.find('input')
    obj = {}
    _.each inputs, (field) ->
      value = field.value
      id = field.id
      obj[id] = value
    if obj['firstName'] == '' || obj['lastName'] == ''
      toastr.warning('Please add a first and last name!')
    else
      Contacts.insert(obj)

Template.activeContact.events
  'click .edit': (e) ->
    e.preventDefault()
    Session.set 'isEditing', true
  'click .favorite': (e) ->
    e.preventDefault()
    if @favorite == true
      Contacts.update(@_id, {$unset: {favorite: ''}})
    else
      Contacts.update(@_id, {$set: {favorite: true}})

Template.editContact.events
  'keyup input': (e) ->
    key = e.currentTarget.id
    value = e.currentTarget.value
    obj = {}
    obj[key] = value
    Contacts.update(@_id, {$set: obj})
  'click .avatar': (e) ->
    e.preventDefault()
    $('#editYourAvatarModal').modal()
  'click .save': (e) ->
    e.preventDefault()
    Session.set 'isEditing', false
  'click .delete': (e) ->
    e.preventDefault()
    if confirm("Are you sure you want to delete this contact? This action cannot be undone.")
      Contacts.remove(@_id)
      Session.set 'isEditing', false
      e.stopPropagation()

Template.contacts.events
  'click .list-group-item': (e) ->
    e.preventDefault()
    Session.set "isEditing", false
    Session.set 'isAdding', false
    Session.set "activeContact", @_id
  'click .add-contact': (e) ->
    e.preventDefault()
    Session.set "activeContact", null
    Session.set "isAdding", true
  'keyup input.searchbox': (e) ->
    if e.currentTarget.value isnt ''
      Session.set "isSearching", true 
    else
      Session.set "isSearching", false
    Session.set "search-query", e.currentTarget.value

 # --- CUSTOM -----
 UI.registerHelper 'active', (context) ->
  if context == Session.get 'activeContact'
    return true