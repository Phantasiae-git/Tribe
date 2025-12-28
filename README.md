# Tribe

## How to set up the environment for the project:

**Note:** Android Studio does not work properly on a VM, flutter+android studio was made to be used on Windows so it’s a bit harder to install on Linux (it’s ok as long as it’s not a VM, just a heads up that installing on Windows is more straightforward)

---

Step 1. Install Flutter (Mobile development framework that uses Dart as a language):

Follow this page https://docs.flutter.dev/get-started/quick

Step 2. Install Android Studio (the thing that lets you run the app in an emulated phone or your own phone connected to the computer via USB):

Follow this page https://developer.android.com/studio/install

Step 3. Set up other BS that you need for this to work:

Follow this page https://docs.flutter.dev/platform-integration/android/setup

## Running the project itself:

After this you can clone the repo, do `npm install` for the backend and `flutter pub get` for the frontend (this installs the needed dependencies). Add the .env that can be found in the project's Notion, then on VS code open the command palette and do Flutter: select device. Choose a virtual phone or your own if it’s connected via USB. Then navigate to main.dart and click on the play icon to run and debug the app!
