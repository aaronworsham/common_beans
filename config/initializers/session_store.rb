# Be sure to restart your server when you modify this file.

CommonBeans::Application.config.session_store :cookie_store, 
                                              :key => '_common_beans_session',
                                              :expire_after   => 86400 #time in seconds

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# CommonBeans::Application.config.session_store :active_record_store
