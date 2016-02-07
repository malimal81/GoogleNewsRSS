# GoogleNewsRSS

GoogleRSS is a News feed that streams the top news stories of the day.
The main storyboard contains a table view with a different story in ech cell.
The cells contain a default picture, the title of the story, and a brief summary.
Once a cell is selected, the view application changes to a another view that initiates a web view with the corresponding story.
The user can read the story in the content view and hit the "done" button to go back to the table view.

The application is designed for iOS devices in portrait orientation.
Testing or running the project file requires Xcode running on a mac computer.

Bugs:
The application currently doesn't work offline.
The image urls will print to the console, but the images won't load in the table cells.
