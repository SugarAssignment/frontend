# sugar_wallet

## Getting Started
This flutter project is used to display all the data that we have stored with the help of app automation

File Structure
->Lib
    -> controller folder (State Management)
        -> controller folder contains user.dart file which is used for state management. In this we are storing 3 important element: 1) City name 2) User Token 3) Data of offers
    -> repository (API Call)
        -> repository folder contains api_call.dart file. We have 5 APIs in it for different purposes: 1) Login User 2) Register User 3) Getting City Names 4) Getting Offers 5) Modifying city in users data 
    -> screens (UI)
        -> screens folder contains homepage_screen.dart, login_screen.dart and register_screen.dart
        -> homepage_screen.dart is used for displaying offer and taking user input for showing offer
        -> login_screen.dart is used to login user to homepage
        -> register_screen.dart is used to register user
    -> main.dart (UI)
        -> main.dart is for initial properties and startup 

