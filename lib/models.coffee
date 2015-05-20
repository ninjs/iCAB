Contacts = new Meteor.Collection('contacts')

Schemas = {}

Schemas.Contact = new SimpleSchema(
  firstName:
    type: String
    regEx: /^[a-zA-Z-]{2,25}$/,
    label: 'firstName'
    max: 25
    min: 2
  lastName:
    type: String
    regEx: /^[a-zA-Z]{2,25}$/,
    label: 'lastName'
    max: 25
    min: 2
  birthday: 
    type: Date
    optional: true
  organization: 
    type: String
    regEx: /^[a-z0-9A-z .]{3,30}$/,
    optional: true
  cell:
    type: String
    label: 'Cell Phone Number'
    optional: true
    min: 7
  home:
    type: String
    label: 'Home Phone Number'
    optional: true
    min: 7
  work:
    type: String
    label: 'Work Phone Number'
    optional: true
    min: 7
  email:
    type: String
    regEx: SimpleSchema.RegEx.Email
    label: 'Email Address'
    optional: true
    min: 7
  streetAddress:
    type: String
    label: 'Street Address'
    optional: true
    min: 7
  city:
    type: String
    label: 'City'
    optional: true
    max: 50
  state: 
    type: String
    regEx: /^A[LKSZRAEP]|C[AOT]|D[EC]|F[LM]|G[AU]|HI|I[ADLN]|K[SY]|LA|M[ADEHINOPST]|N[CDEHJMVY]|O[HKR]|P[ARW]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY]$/
    label: 'State'
    optional: true
  zip:
    type: String
    regEx: /^[0-9]{5}$/
    label: 'Zip'
    optional: true
  summary:
    type: String
    label: 'Brief summary'
    optional: true
    max: 1000)

Contacts.attachSchema(Schemas.Contact)