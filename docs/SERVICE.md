# Service Generator Documentation
This boilerplate is using `dry-monads` gem for service structure. If you need service, you can use custom service generator like that:
```bash
$ rails generate service Facebook::Adset 
```

Then, it will create some service classes for your operations.
```
create  app/services/facebook_service/adset/create.rb
create  test/services/facebook_service/adset/create_test.rb
create  app/services/facebook_service/adset/update.rb
create  test/services/facebook_service/adset/update_test.rb
create  app/services/facebook_service/adset/destroy.rb
create  test/services/facebook_service/adset/destroy_test.rb
create  app/services/facebook_service/adset/list.rb
create  test/services/facebook_service/adset/list_test.rb
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
