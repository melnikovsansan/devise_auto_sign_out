# DeviseAutoSignOut
Auto logout using js after Devise session expired

## Installation


Add this line to your application's Gemfile:

```ruby
gem 'devise_auto_sign_out'
```

And then execute:

    $ bundle
    
Add the following to your `app/assets/javascripts/application.js`:

```js
//= require devise_auto_sign_out
```

Add module `DeviceAutoSignOut::SessionControllerExtension` to `SessionController`

```ruby
class SessionsController < Devise::SessionsController
  include DeviceAutoSignOut::SessionControllerExtension
end
```

Add route to `config/routes.rb`:

```ruby
devise_scope :user do
  get 'account/active', to: 'sessions#active'
end
```

Add time out devise module to `ActiveRecord` model `app\models\user.rb\`: 

```ruby
devise :timeoutable, timeout_in: 15.minutes
```

## Usage

It will be used with default settings: 

```js
DeviceAutoSignOut = {
  interval: 6000,
  signInPath: '/account/sign_in',
  activePath: '/account/active'
};
```

Rewrite this settings if need in your js config files.
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/devise_auto_sign_out. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

