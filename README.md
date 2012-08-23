twilio-demo
===========

A Demo Application to show the benefits of Twilio (http://www.twilio.com) to the audience of RubyShift Munich. 


Features
--------

- verify a phone number you own
- send / receive text messages
- call a phone
- read messages via speech engine
- play mp3 on the phone (e.g. pre-recorded messages)
- know which keys the callee pressed
- set up a conference call
- record a call
- transcribe a recording

Installation
------

- get a (free) account at http://www.twilio.com
- create a twilio application in your account settings 
- enter your credentials (auth_token, account sid, app sid) in `config/initializers/twilio.rb`
- you are good to go

Principles
------

- I tried to add the relevant source code in each of the views
- I did NOT use test driven development (tests are painfully slow on Windows)

