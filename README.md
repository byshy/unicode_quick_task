# QuickTask

QuickTask is a Flutter project developed as part of an assessment to simulate the challenges of managing multiple client requirements within a single codebase. The project involves creating a TODO app customized for two distinct clients: **PRO** and **Regular**. Each client has unique requirements and operates in separate development and production environments.

## Overview

### Clients
- **PRO Client:** Requires the TODO app to sync tasks with a remote server every 6 hours, as defined in the Service Level Agreement (SLA).
- **Regular Client:** Does not require task synchronization with a remote server.

### Environment Configuration
QuickTask is designed with modularity in mind, allowing easy management of client-specific features through separate configurations:
- **PRO Client:**
    - Separate development and production environments.
    - Dedicated Firebase project for each environment.
    - Unique app icon for each environment.
    - Task synchronization feature enabled.
- **Regular Client:**
    - Separate development and production environments.
    - Dedicated Firebase project for each environment.
    - Unique app icon for each environment.
    - Task synchronization feature disabled.

**Note:** The current code structure allows for the easy addition of more environments, such as a staging environment, by simply creating new configurations and linking them to their respective Firebase projects and assets.

## Project Structure
The project structure is organized to facilitate easy management and scalability:
- **assets/**: Contains
    - base and environment-specific configurations for both PRO and Regular clients.
    - Font files
    - Images (both generic and customer specific)
    - Translation files (both generic and customer specific)
- **lib/features/**: Houses all the features in the system. Each feature consists of
    - State management solution (BLoC in our case)
    - Screens
    - Widgets
    - etc. (bottom sheets, helpers, and other optional directories)

## Key Features
- **Modular Configurations:** Easily switch between different client environments using dedicated configuration files.
- **Custom Icons:** Each client has a distinct app icon to reflect their branding.
- **Firebase Integration:** Each environment is linked to its own Firebase project, ensuring data separation.
- **Task Synchronization:** Automated task synchronization is implemented for the PRO client.

## Getting Started

### Prerequisites
- Flutter SDK

### Installation
1. Clone the repository.
2. Run the app using the desired environment configuration:

```bash
flutter run --flavor proDev --dart-define="flavor=pro_dev"
flutter run --flavor proProd --dart-define="flavor=pro_prod"
flutter run --flavor regularDev --dart-define="flavor=regular_dev"
flutter run --flavor regularProd --dart-define="flavor=regular_prod"
```

## Conclusion
QuickTask demonstrates the ability to manage and scale a multi-client Flutter application with distinct requirements. This modular approach ensures flexibility and efficiency in meeting various client needs.