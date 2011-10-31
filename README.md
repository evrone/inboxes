#Inboxes

Inboxes is a young messaging system for Rails app. It:

- provides 3 models for developers: Discussion, Message and Speaker
- read/unread discussions counter
- any user can be invited to discussion by the member of this discussion, so you can chat with unlimited number of users

#Requirements and recommendations

Inboxes requires Rails 3.x and [Devise](https://github.com/plataformatec/devise) for user identification (surely, messaging system is not possible without users).

We recommend you to use it with [Faye](https://github.com/jcoglan/faye), because it's really very useful with it.