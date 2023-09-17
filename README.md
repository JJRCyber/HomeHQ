# HomeHQ

### IMPORTANT INFORMATION

**************************Demo Account:**************************

These accounts are all connected to a demo home so have items already added into shopping list, notices, etc

**************Email:************** demo@homehq.com ********************Password:******************** Homehq1

**************Email:************** demo2@homehq.com ********************Password:******************** Homehq1

**************Email:************** demo3@homehq.com ********************Password:******************** Homehq1

New accounts can be created but they will need to join or create a home before they have access to the majority of features. The join home feature relies on a QR scanning library which is not accessible in the simulator, instead a prompt will be displayed that will join you to the demo home.

************************Disclaimers:************************

- Firebase Authentication code was written previously to this subject. These files have been commented to mention this.
- Logo image was created using Midjourney AI image generator.
- Sign In with Apple will not work when building app as it requires my Apple Developer account to sign the app when building.

### Overview

The overarching idea for the app I have built is to make managing a house hold easier by having a centralised place to share information, tasks, notices and costs. I found that living in a share house myself I was using multiple apps to manage tasks such as cost splitting, household reminders, shared shopping lists and notifying other house members of important information such as house maintenance or repairs.

This app development project has allowed me to improve my software architecture skills and explore the challenges of creating a cloud storage based app. The app currently features a limited number of screens with the ability for users to sign up, create or join a home and then use a fully functional shared shopping list and notice board system. All of this data is hosted on Firebase using their Firestore database. This allows real time collaboration between household members within the app. The app has been tested amongst my household and received positive feedback. I plan to continue revising and improving this app over the coming months.

### Initial Planning + Development

Due to the fact I wanted to develop this further after the completion of this project I planned to build foundations for the storing of the apps data both locally and synchronised with a cloud database. As I have previously worked with Firebase and Firestore I implemented the authentication code that I had previously written and then began the Firestore implementation from that. I underestimated the amount of work each screen and the accompanying backend code would take and had to revise my development to thoroughly design the backend infrastructure for a limited amount of pages rather than developing basic versions of all screens.

### Challenges Encountered

- **************************************Local Data Storage:************************************** My initial plan was to store a copy of this data locally to prevent delays with the app loading data from server on each screen but I had to revise this plan as it proved difficult to ensure the integrity of data when storing both a local copy and fetching copy from Firestore. My current implementation relies on Firestore to be the single source of truth for this data. The data has been structured in 2 seperate collections of users and homes. At this time a user can only belong to one home at a time and must leave that home if they want to join another one.
- ******************************************************Asynchronous Data Loading:****************************************************** As all the user and home data is being fetched from Firestore in asynchronous functions it was a challenge to manage the loading of the information to be displayed on each view. I had to ensure appropriate views were shown based on loading different loading states (idle, loading, loaded and error). This meant that an increased amount of code had to be written per view for each screen.
- ************************************Creating Widget Views:************************************ As I wanted to have widget subviews on the dashboard of my app this meant I had to create twice the amount of views for each screen and also had to manage additional view models to fetch the data from Firestore. This increased development time but I am happy with the end result.

Overall I found these challenges provided me with a better understanding of the intricacies of creating an app that provides a seamless integration between cloud stored data and local offline storage. I plan to develop this app further to integrate a robust offline storage mechanism and functions to synchronise data the data with Firestore when needed rather than solely relying on fetching the data from Firestore on every view load.

### Key Features and Functionality

- **************************Architecture:************************** My app was designed using MVVM architecture to be allow for easy revision and expansion as well as separating of concerns to allow code re-use.
- **OOP and Protocols:** All viewmodels inherit from the BaseViewModel class which also includes multiple protocols that are used throughout the app to implement common features such as view refreshing, adding items and loading data.
- ******************User Interface Design:****************** The app features a dashboard with smaller views display the key items from the main view pages. It also utilises the SwiftUI built in TabBar view for ease of access to all pages.
- ************Error Handling:************ All errors are thrown and caught appropriately throughout the app and will display an alert popup on the corresponding view to communicate the error to the user.
- ********************************************Testing and Debugging:******************************************** The app has been user tested among a small group of people and Xcodes internal debugging tools have been utilised to examine and fix issues.
- ********************************Version Control Usage:******************************** GitHub was used for version control with this project having multiple branches and over 60 commits.
- **********************************************************Currently Available Features**********************************************************
    - Sign up, sign in, sign out (Firebase Authentication)
        - Google Sign In
        - Apple Sign In
    - Edit user + home profile (Firebase Firestore)
        - Change username
        - Change name
        - Change home name
        - Change mobile
    - Dashboard widgets (Firebase Firestore)
        - Shopping List
        - Notices
    - Shopping List (Firebase Firestore)
        - Add
        - Change quantity
        - Delete
        - Mark completed
    - Notice Board (Firebase Firestore)
        - Add
        - Delete
