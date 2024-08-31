## QuickTask - A Multi-Client Flutter Application

### Overview

QuickTask is a Flutter project designed to simulate the challenges of managing multiple client requirements within a single codebase. It's a TODO app customized for two distinct clients: **PRO** and **Regular**. Each client has unique features and operates in separate development and production environments.

### Key Features

- **Modular Configurations:** Easily switch between different client environments using dedicated configuration files.
- **Custom Icons:** Each client has a distinct app icon to reflect their branding.
- **Firebase Integration:** Each environment is linked to its own Firebase project, ensuring data separation.
- **Task Synchronization:** Automated task synchronization is implemented for the PRO client.

### Client Differences

| Feature              | PRO Client                                                                                                                       | Regular Client                                                                                                                           |
|----------------------|----------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| App Icon             | ![PRO Client Icon](https://github.com/byshy/unicode_quick_task/blob/main/apps/quick_task/android/app/src/pro/play_store_512.png) | ![Regular Client Icon](https://github.com/byshy/unicode_quick_task/blob/main/apps/quick_task/android/app/src/regular/play_store_512.png) |
| Onboarding           | 4 screens for comprehensive introduction                                                                                         | 3 screens for simpler introduction                                                                                                       |
| Task Synchronization | Syncs with remote server every 6 hours (SLA requirement)                                                                         | No remote server synchronization                                                                                                         |
| Environment Setup    | Separate development and production environments (dedicated Firebase projects)                                                   | Separate development and production environments (dedicated Firebase projects)                                                           |
| Theme                | Green                                                                                                                            | Orange                                                                                                                                   |

### Project Structure

The project structure is organized to facilitate easy management and scalability:
- **assets/**: Contains
  - Base and environment-specific configurations for both PRO and Regular clients.
  - Font files
  - Images (both generic and customer-specific)
  - Translation files (both generic and customer-specific)
- **lib/features/**: Houses all the features in the system. Each feature consists of
  - State management solution (BLoC in our case)
  - Screens
  - Widgets
  - etc. (bottom sheets, helpers, and other optional directories)

### Testing

The project is thoroughly tested using both unit tests and integration tests. The commands required to run the integration tests are provided in the [README.md](apps/quick_task/integration_test/README.md) file located inside the `test/integration` directory.

### Getting Started

#### Prerequisites
- Flutter SDK (the app was developed using v3.22.2)
- Run the setup script found in the script directory, please check the [README.md](scripts/README.md) file there for how to run it and what it does.

#### Installation
1. Clone the repository.
2. Run the app using the desired environment configuration:

```
flutter run --flavor proDev --dart-define="flavor=pro_dev"
flutter run --flavor proProd --dart-define="flavor=pro_prod"
flutter run --flavor regularDev --dart-define="flavor=regular_dev"
flutter run --flavor regularProd --dart-define="flavor=regular_prod"
```

### Conclusion

QuickTask demonstrates the ability to manage and scale a multi-client Flutter application with distinct requirements. This modular approach ensures flexibility and efficiency in meeting various client needs.