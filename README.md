#Inboxes

Inboxes is a young messaging system for Rails app. It:

- provides 3 models for developers: Discussion, Message and Speaker
- read/unread discussions counter
- any user can be invited to discussion by the member of this discussion, so you can chat with unlimited number of users

##Requirements and recommendations

Inboxes requires Rails 3.x and [Devise](https://github.com/plataformatec/devise) for user identification (surely, messaging system is not possible without users).

We recommend to use Inboxes with [Faye](https://github.com/jcoglan/faye), because it's really useful with it.

Remember that unfortunately, Inboxes reserve 3 model names: Discussion, DiscussionView, Message and Speaker and 2 controller names: Messages and Discussions.

##Installation

*Make sure that Devise is already installed and configured!*

1. Add `gem "inboxes", :git => git://github.com/kirs/inboxes.git` to your `Gemfile` and run `bundle install`
2. Run `rails generate inboxes:install`. This command will generate migration for messaging system. Don't forget to run migrations: `rake db:migrate`
3. Add `inboxes` to your User model like [here](https://gist.github.com/1330080)
4. Now Inboxes is ready to use. Open `http://yoursite.dev/discussions` to show discussions list. You can start new one.

Default Inboxes views are ugly, so you can copy it to your app and make anything with them: `rails generate inboxes:views`
If you have problems with installation if gem, you can check [demo app code](https://github.com/kirs/inboxes-app)

## I18n

By default, this gem provides localized phrases for Russian and English languages. You can easily override any of them. [Here is](https://github.com/kirs/inboxes/blob/master/config/locales/en.yml) list of all I18n phrases.

##Todo

- Add rspec tests
- Move gem resources to namespace
- Describe integration with Faye

##Authors

- [Kir Shatrov](https://github.com/kirs/) (Evrone Company)

##Feel free for pull requests!