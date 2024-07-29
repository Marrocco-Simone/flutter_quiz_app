# Device-Agnostic Design Course Project I - 8078393e-b90c-49e3-b7cf-0a27a3583e42

## Name of the application:

**Quiz App!**

## Brief description of the application

This **Quiz App!** was created as the first project of the _Device Agnostic Design_ course of the _Aalto University_. It follows all the requirements for passing with merits.

### Features

- Get and show the list of topics from an API
- Select a topic and answer the question until you get the right answer
- Colored and cheerful buttons, change color of answers to reflect if right or wrong
- Images support for questions
- Continue playing with the same topic, or use the Practice mode to play the topic with less points
- See your statistics, with the total correct answers and the points per topic ordered
- Reset your statistics and play again from scratch
- Mobile version, transforming the top bar from a Row to a Column when veiwport is not too wide

### For devs

- 100% test coverage - everything is covered!
- Providers, routes, screens, API services and styles classes
- Code divided between multiple Widgets for high mantenability and code reuse
- Test divided in ordered manner
- Written in Flutter

## Key challenges faced during the project

- It looks like you cannot assign a _List\<dynamic\>_ to a _List\<String\>_ without before explicitly assigning it to a variable defined as _List\<dynami\c>_ (otherwise, for example, data['options'] fails when assigned to a _List\<String\>_ directly). Same thing applies to _Map\<String, dynamic\>_.

- In tests, initialize all mock classes for Shared Preferences and API calls

- Nock requires to explicitly say that an api is called multiple times

## Key learning moments from working on the project

- How I learned Generics in Flutter to make a generic API wrapper

- Scrollable widgets and responsive layout, for mobile version of the website

- fromJson and toJson methods to convert easily custum classes saved in localStorage

- Sort and Comparable interface to easily use default functions

## List of dependencies and their versions

- sdk: ">=3.4.1 <4.0.0"
- cupertino_icons: ^1.0.6
- http: ^1.2.1
- go_router: ^14.1.4
- shared_preferences: ^2.2.3
- flutter_lints: ^3.0.0
- nock: ^1.2.3
