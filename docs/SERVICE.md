# Service Generator Documentation
This boilerplate is using `dry-monads` gem for service structure. If you need service, you can use custom service generator like that:
```bash
$ rails generate service Facebook::Adset 
```

Then, it will create some service classes for your operations.
```
create  app/services/facebook/adset_service.rb
create  test/services/facebook/adset_service_test.rb
```

You can access service templates from `/lib/generators/service` folder.

# Sample list service usage
```ruby
class UsersController < ApplicationController
  def index
    service = UserService::List.new(query: query_object,
                                    pagination: pagination_object).call

    @users = service.success
  end
end
```
