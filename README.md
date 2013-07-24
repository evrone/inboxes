#Inboxes

[![Build Status](https://secure.travis-ci.org/evrone/inboxes.png)](http://travis-ci.org/evrone/inboxes)

## Rails 4 status

Gem is not ready for Rails 4 (honestly, I didn't see any requests yet). If you need it, I would be happy to collaborate and make it capable with new Rails. Don't hesitate to drop me a line: [shatrov@me.com](shatrov@me.com)

Inboxes is a young messaging system for Rails app. It:

- provides 3 models for developers: Discussion, Message and Speaker
- read/unread discussions counter
- any user can be invited to discussion by the member of this discussion, so you can chat with unlimited number of users
- have configurable behavior via CanCan Ability

##Requirements

Inboxes requires Rails 3.x and [Devise](https://github.com/plataformatec/devise) for user identification (surely, messaging system is not possible without users).
We recommend to use Inboxes with [Faye](https://github.com/jcoglan/faye), because it's really sexy with it.

Remember that unfortunately, Inboxes reserve 3 resources names: Discussion, Message and Speaker.

Since version 0.2.0, it is possible to add `has_inboxes` option to any model. For instance, it can be `Person` or `Teacher`.

##Installation

*Make sure that [Devise](https://github.com/plataformatec/devise) and [CanCan](https://github.com/ryanb/cancan) are already installed and configured in your app!*

1. Add `gem "inboxes", "~> 0.2.0"` to the `Gemfile` and run `bundle install`
2. Execute `rails generate inboxes:install`. This command will generate migration for messaging system. Don't forget to run migrations: `rake db:migrate`
3. Add `has_inboxes` to your User model like [here](https://gist.github.com/1330080).
4. Add CanCan abilities to manage Inboxes models:

```ruby
can [:index, :create], Discussion
can :read, Discussion do |discussion|
  discussion.can_participate?(user)
end
```

5. Now Inboxes are ready to use. Open `http://yoursite.dev/discussions` to see the list of discussions. You can start new one.

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

*While running Inboxes with Faye, don't forget to run Faye worker it: `rackup faye.ru -s thin -E production`*
You can read more about that on it's [official page](http://faye.jcoglan.com/).

### Hints

1. If you want to add breadcrumbs to Inboxes pages, we recommend you to use [crummy gem](https://github.com/zachinglis/crummy). It allows to define breadcrumbs in views.

##Upgrading from 0.1 to current version (0.2)

**Run `rails generate inboxes:upgrade_discussible` and then roll up the migration. Your DB is upgraded!**

##Todo

- Finalize RSpec tests (are located in [rspec branch](https://github.com/evrone/inboxes/tree/rspec))
- Add Pusher capability
- Email notifications and the ability to answer received emails like in Github issues (#7)

## [Changelog](https://github.com/evrone/inboxes/blob/master/CHANGELOG.md)

##Contributors

- [Kir Shatrov](https://github.com/kirs/) (Evrone Company)
- [Nikolay Seskin](https://github.com/finist/) (Evrone Company)
- [Andrey Ognevsky](https://github.com/ognevsy/) (Evrone Company)
- [Alexander Brodyanoj](https://github.com/dom1nga)
- [Dmitriy Kiriyenko](https://github.com/dmitriy-kiriyenko)
- [Alexey Poimtsev](https://github.com/alec-c4) ([http://progress-engine.ru/](Progress Engine))
- [isqad88](https://github.com/isqad88/)
- [Chris Sargeant](https://github.com/liothen/)

##Feel free for pull requests!
