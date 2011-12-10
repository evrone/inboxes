#Inboxes

Inboxes is a young messaging system for Rails app. It:

- provides 3 models for developers: Discussion, Message and Speaker
- read/unread discussions counter
- any user can be invited to discussion by the member of this discussion, so you can chat with unlimited number of users

##Requirements and recommendations

Inboxes requires Rails 3.x and [Devise](https://github.com/plataformatec/devise) for user identification (surely, messaging system is not possible without users). Now the gem is tested only with Ruby 1.8.7 and REE.

We recommend to use Inboxes with [Faye](https://github.com/jcoglan/faye), because it's really sexy with it.

Remember that unfortunately, Inboxes reserve 3 resources names: Discussion, Message and Speaker.

##Installation

*Make sure that Devise is already installed and configured in your app!*

1. Add `gem "inboxes", "~> 0.1.2"` to the `Gemfile` and run `bundle install`
2. Execute `rails generate inboxes:install`. This command will generate migration for messaging system. Don't forget to run migrations: `rake db:migrate`
3. Add `has_inboxes` to your User model like [here](https://gist.github.com/1330080)
4. Now Inboxes are ready to use. Open `http://yoursite.dev/discussions` to see the list of discussions. You can start new one.

Default Inboxes views are ugly, so you can copy into your app and make anything with them: `rails generate inboxes:views`
If you have problems with installation, you can check [code of demo app](https://github.com/kirs/inboxes-app)

## I18n

By default, the gem provides localized phrases for Russian and English languages. You can easily override any of them. [Here is](https://github.com/kirs/inboxes/blob/master/config/locales/en.yml) list of all I18n phrases.

#Integration with Faye

You can watch the demo of integration [on YouTube](http://youtu.be/c12gey9DvyU)

1. Add `gem "faye"` to your Gemfile and run `bundle install`. Install Faye by [the screencast](http://railscasts.com/episodes/260-messaging-with-faye)
2. Create `messaging.js` in `app/assets/javascripts/` with this line: `//= require inboxes/faye`

3. Copy or replace 2 views from Inboxes example app to your application: [app/views/inboxes/messages/_form](https://github.com/kirs/inboxes-app/blob/master/app/views/inboxes/messages/_form.html.haml) and [app/views/inboxes/messages/create](https://github.com/kirs/inboxes-app/blob/master/app/views/inboxes/messages/create.js.erb)

4. Add config parameters to your application config (last 2 are not necessary):

```ruby
config.inboxes.faye_enabled = true
config.inboxes.faye_host = "inboxes-app.dev" # localhost by default
config.inboxes.faye_port = 9292 # 9292 by default
```

5. Faye installation is finished. If you have any troubles, check the [example app](https://github.com/kirs/inboxes-app/)

*While testing Inboxes with Faye, don't forget to run it: `rackup faye.ru -s thin -E production`*
You can read more about Faye on it's [official page](http://faye.jcoglan.com/).

### Hints

1. If you want to add breadcrumbs to Inboxes pages, we recommend you to use [crummy gem](https://github.com/zachinglis/crummy). It allows to define breadcrumbs in views.

##Todo

- Add RSpec tests

##Contributors

- [Kir Shatrov](https://github.com/kirs/) (Evrone Company)
- [Andrey Ognevsky](https://github.com/ognevsy/) (Evrone Company)
- [Alexander Brodyanoj](https://github.com/dom1nga)
- [Dmitriy Kiriyenko](https://github.com/dmitriy-kiriyenko)

##Feel free for pull requests!
