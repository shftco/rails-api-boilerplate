# Form Generator Documentation
This boilerplate is using `reform-rails` gem for form structure. If you need form, you can use custom form generator like that:
```bash
$ rails generate form User::Registration 
```

Then, it will create some service classes for your operations.
```
create  app/forms/user_form/registration.rb
create  test/forms/user_form/registration_test.rb
```

You can access service templates from `/lib/generators/form` folder.
