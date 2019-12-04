# Cíngulo Flutter Sample

|           | master                                                                                                                                                                   | develop                                                                                                                                                                   |
|-----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Travis CI | [![Build Status on master](https://travis-ci.com/cingulo/cingulo-api.svg?token=S6fmxWi658YBt67BpxHk&branch=master)](https://travis-ci.com/cingulo/cingulo-api)           |  [![Build Status on develop](https://travis-ci.com/cingulo/cingulo-api.svg?token=S6fmxWi658YBt67BpxHk&branch=develop)](https://travis-ci.com/cingulo/cingulo-api)         |
| Coveralls | [![Coverage Status on master](https://coveralls.io/repos/github/cingulo/cingulo-api/badge.svg?branch=develop&t=OUomCN)](https://coveralls.io/github/cingulo/cingulo-api) | [![Coverage Status on develop](https://coveralls.io/repos/github/cingulo/cingulo-api/badge.svg?branch=develop&t=OUomCN)](https://coveralls.io/github/cingulo/cingulo-api) |

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

# Dependency Injection

This project uses [inject.dart](https://github.com/cingulo/inject.dart). You will have to clone it under vendor/inject.dart:

```
    $ cd <repository-root>
    $ git clone https://github.com/cingulo/inject.dart.git vendor/inject.dart
```

Use the command below to build the dependency injection:

```
    $ flutter packages pub run build_runner build --build-filter "lib/data/*/*.dart" --delete-conflicting-outputs
    $ flutter packages pub run build_runner build --build-filter "lib/app/*.dart" --delete-conflicting-outputs
```

- Done, you should now be good to run the app. 


# API Docs

Open [the docs URL](https://api-sample.cingulo.com/docs) in your browser. You can also check [the API GitHub repository](https://github.com/cingulo/api-sample).
