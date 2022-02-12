# Service Generator Documentation
This boilerplate is using `dry-monads` gem for service structure. If you need service, you can use custom service generator like that:
```bash
$ rails generate service Facebook::Adset 
```

Then, it will create some service classes for your operations.
```
create  app/services/facebook_service/adset/create.rb
create  app/services/facebook_service/adset/update.rb
create  app/services/facebook_service/adset/destroy.rb
create  app/services/facebook_service/adset/list.rb
```

You can access service templates from `/lib/generators/service` folder.
