# Contract Generator Documentation
This boilerplate is using `dry-validation` gem for contract structure. If you need contract, you can use custom contract generator like that:
```bash
$ rails generate contract Users::Registration 
```

Then, it will create some service classes for your operations.
```
create  app/contracts/users/registration_contract.rb
create  test/contracts/users/registration_contract_test.rb
```

You can access service templates from `/lib/generators/contract` folder.
