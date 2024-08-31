# Running the integration test

## To run the integration test on the different flavors use the following commands

> Please remember to change the target to the test you want to run

For the PRO Prod environment
```
flutter run --target=test_driver/integration/tests/pass_on_boarding_test.dart --flavor=proProd --dart-define=flavor=pro_prod
```

For the PRO Dev environment
```
flutter run --target=test_driver/integration/tests/pass_on_boarding_test.dart --flavor=proDev --dart-define=flavor=pro_dev 
```

For the Regular Prod environment
```
flutter run --target=test_driver/integration/tests/pass_on_boarding_test.dart --flavor=regularProd --dart-define=flavor=regular_prod 
```

For the Regular Dev environment
```
flutter run --target=test_driver/integration/tests/pass_on_boarding_test.dart --flavor=regularDev --dart-define=flavor=regular_dev 
```
