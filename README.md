# Catapult

A Cat tagging API

To setup the app:
1. `rake db:create`
1. `rake db:migrate`
1. `bundle install`
1. `rails s`

Tests can be run with:
`rspec spec` 


Api Decisions:
I decided to nest the `breeds/:id/tags` path within the breeds resource because it felt more suited given breeds was at the beginning of the URL.
