# RemindMe
SignEasy Task

Create a “Smart Reminder” app with following specifications

The “Reminder” part
- The app works as a “Reminder” app in which you can create reminders [Title and datetime , title is derived using “Smart detection” method]
- The app should send local notification when the reminder is due [lets keep it 5 minutes before the reminder time for simplicity]
- User should be able to mark a reminder as “complete”. - The app will have 2 sections [ in a table view] - “Reminders” and “Overdue”. New items will appear under “Reminder” section and the items which are overdue will appear under “overdue” section. “Completed” items should disappear.

What is a “Smart” reminder
- This is where the challenging and fun part comes.
- Unlike the traditional “type and save” method , you should use a “smart” method to create reminders. This is how it works
1. Take a photo of the object
2. The app should be able to “detect the photo” and assign it to a “Type of object”. Lets consider the types to be “Vehicle” , “Apparels” , “Groceries” and “Books” [You know which Apple Framework to use !]
For time being :
Any photo of Bike or Car should be considered as vehicle
Any photo of Jeans , shirt or T-shirt should be considered as Apparels
Any photo of Tomato,Potato,Onion should be considered as Groceries
Any photo of Oxford dictionary and merriam-webster dictionary should be considered as book

3. Once the “Type” is detected , the app should show the list of common tasks associated with the Type
Eg:
Vehicle - Give it for Service , Wash , Change oil , Refuel Apparels - Give it to laundry, Wash, Iron , Exchange/ Alter , Return
Groceries - Order Groceries
Books - Return to library,Order online, Return to friend, Enquire in library
4. Once task is selected from list of available tasks - assign due date and time

Notes:
- You do not enter the Task manually by typing in the app, Take a phone and just select from the list.If the photo doesn’t belong to any of the categories just ignore it for time being
- The app should persist data between the app
sessions / app relaunch.
- Code should follow the best coding guidelines and practices
- Use appropriate design patters
- App should support iPhone/iPad
- The design is upto you . We want to see how best you can come up with the UI/UX part.
- Please upload your task to GitHub and share the link
 
 
