# star_wars_app

Flutter project using StarWars API (SWAPI)
# Packages Used in this project

This README file provides an overview of the packages we are using in our Flutter project, along with a brief description of their purpose and function within the application.

## Packages

### chuck_interceptor

- **Purpose:** This package is used to read information about the HTTP requests made by the application.
- **Functionality:** It allows us to intercept and visualize the content of HTTP requests, which is useful for debugging and analyzing communication with the server.

### http

- **Purpose:** Provides functionalities for making HTTP requests from the application.
- **Functionality:** Facilitates communication with remote servers to fetch and send data using various HTTP methods such as GET, POST, PUT, DELETE, etc.

### get_it

- **Purpose:** A dependency injection package for managing object dependency throughout the application.
- **Functionality:** Enables the creation and access of object instances in different parts of the application, facilitating modularity and code reuse.

### flutter_bloc

- **Purpose:** A library that implements the Bloc (Business Logic Component) pattern for state management in Flutter applications.
- **Functionality:** Facilitates the separation of presentation logic from business logic, improving code organization and testability.

### dartz

- **Purpose:** Provides functional programming tools for Dart and Flutter.
- **Functionality:** Offers immutable data types and higher-order functions that facilitate error handling, asynchronous operations, and data manipulation in a more declarative and safe manner.

### equatable

- **Purpose:** A package that simplifies object comparison in Dart, in this case is used in BloC state, and Failures.
- **Functionality:** Allows concise definition of immutable data classes and provides methods for comparing instances of these classes based on their content.

### bloc_concurrency

- **Purpose:** A package that provides support for controlling concurrency in applications using the Bloc pattern, in this case is used to Infinite list BloC to avoid concurrency to many fetch.
- **Functionality:** Enables safe management of concurrency in event and state execution in blocs, avoiding synchronization issues and race conditions.

### connectivity_plus

- **Purpose:** Provides functionalities for monitoring network connectivity on mobile devices.
- **Functionality:** Allows checking the Internet connection status and detecting changes in connectivity, which is useful for adapting the application behavior based on network availability.

### flutter_local_notifications

- **Purpose:** A package for displaying local notifications to go to Chuck Interceptor.
- **Functionality:** Enables scheduling and displaying notifications on the user's device, which is useful for sending alerts and reminders within the application.
