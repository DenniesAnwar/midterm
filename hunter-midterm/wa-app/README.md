# Option #1  - Debug an APP

For those that chose option #1:

### Goal:  
- Debug the App and then deploy the app to your firebase hosted instance until you get the google signup popup screen like the below.
- https://www.screencast.com/t/r2FaLYTkYyTj


#### Some Requirements:
1. You'll need to deploy the app to a new or current firebase project. 
2. Invite the professor as a collaborator
3. Commit the project changes to your individual gitlab repos in a new branch called "Your FirstName-LastName-Hunter-Midterm.


#### Some Helpful Notes:

##### You may or may not need to run some of the following commands:
- run flutter pub update
- dart pub cache clean
- Watch for file paths that don't actually exist (ie. "assets/env/).  You can remove these if necessary.
- Watch out for ghost icons (ie. \wa-app\web\icons\Icon-192.png).  You can remove these if necessary

- When access is denied - try to run from administrator mode.
- Pay careful attention to any Flutter Degub messages you receive.


Don't forget to authorize the necessary urls/domains in order to get Firebase Auth to work.
This can be done within Firebase or GCP from the Auth2- You will need to set your Auth2 Client Ids from Google Cloud 
https://www.screencast.com/t/GjpspUIiM
You will be taking A new Flutter project.

# Option #2  - Build a single page application

Navigate to the web app - https://alphabetacreatives.com/#/

You are going to build your own single page portfolio site and deploy on firebase.

#### Requirements:

- Must have a real profile picture of yourself. If you prefer an avatar, you can create a free avatar from one of these sites - https://www.zmoji.me/9-sites-to-create-cartoon-avatars/
- Must include a Social Media Active Link and social media icon image on the bottom of the page underneath the paragraph text.  This can be any social media platform  I would recommend using url launhcer flutter package.
- Your Name must be listed on the top left or top right of the page
- Menu items are not needed.
- Include the title "Flutter Developer' above the paragraph text
- You need a paragraph about yourself (This can be any text about youself).
- Note that You can swap (left to right/right to left) the photo and the paragraph text