# Cíngulo Flutter Sample

| Status    | develop                                                                                                                                                                    |
|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Travis CI | [![Build Status](https://travis-ci.com/cingulo/flutter-sample.svg?branch=develop)](https://travis-ci.com/cingulo/flutter-sample)                                           |
| Coveralls | [![Coverage Status](https://coveralls.io/repos/github/cingulo/flutter-sample/badge.svg?branch=adjusts)](https://coveralls.io/github/cingulo/flutter-sample?branch=adjusts) |

[Check out a short demo video here.](https://github.com/cingulo/flutter-sample/blob/develop/screenshots/0_demo.mp4)  
[Check out some screenshots here.](https://github.com/cingulo/flutter-sample/tree/develop/screenshots)

A fully working sample Flutter app implementation. Give this repo a Star if you like it :)

- Layers separation (data, domain, logic, ui)
- Network calls and very simple caching and concurrency mechanism
- Generic error handling
- Forms validation
- Generic bloc structure
- RxDart
- Dependency injection
- Authentication with JWT and daily renewal
- Themes
- Multiple languages
- Named routes
- Named routes with parameters
- Names routes with simple permission control
- Analytics and pushes skeleton
- We have published [the API](https://api-sample.cingulo.com/docs) so that you can test the app
- Looks good but... it is still missing tests (TODO) :(

## Dependency Injection

This project uses [inject.dart](https://github.com/cingulo/inject.dart). We only had to fork it from Google in order to bump a version dependency. You will have to clone it under vendor/inject.dart:

```
    $ cd <repository-root>
    $ git clone https://github.com/cingulo/inject.dart.git vendor/inject.dart
```

Use the commands below to build the dependency injection:

```
    $ flutter packages pub run build_runner build --build-filter "lib/data/*/*.dart" --delete-conflicting-outputs
    $ flutter packages pub run build_runner build --build-filter "lib/app/*.dart" --delete-conflicting-outputs
```

- Done, you should now be good to run the app. 


## Structure

- `app/` Where the starting MaterialApp resides.
- `common/` Abstract app-wide base classes.
- `data/` Data handling.
- `data/*_repository.dart` Frontier between app models and data storage.
- `errors/` Custom app errors.
- `models/` App models, independent of how `data/*_repository.dart` handles it (db, api, file, in memory, etc).
- `screens/` App screens, may also have screen-specific sub widgets.
- `screens/*_bloc.dart` Screen/widget business logic.
- `services/` App-wide logic like analytics, crashes, l10n, pushes, refresh and routes.
- `themes/` App themes.
- `widgets/` App-wide widgets. Design system components would reside here, for example.
- `env.dart` Envs.
- `main.dart` Entry point.

## Routes

Routes must be [instantiated here](https://github.com/cingulo/flutter-sample/blob/1c2c8bbe7fa430e69d9655dc1bde6589c5bc44e5/lib/services/router_service.dart#L18) to be available for nacigation.

## L10n

L10n delegates must be [listed here](https://github.com/cingulo/flutter-sample/blob/1c2c8bbe7fa430e69d9655dc1bde6589c5bc44e5/lib/services/l10n_service.dart#L21) to be available.


## API Docs

Open [the docs URL](https://api-sample.cingulo.com/docs) in your browser. You can also check [the API GitHub repository](https://github.com/cingulo/api-sample).
