This project involves configuring Firebase Push Notifications with the following features:

Notification Sending: There are two methods to send notifications:

FCM Token: Sending notifications directly to a specific device using its unique FCM token.

Topic Subscription: Sending notifications to all devices subscribed to a specific topic.

In this project, we are using the topic subscription method. The application will have two text fields: one for the title and one for the body of the notification. After entering the information, the user can click the "Send" button to send the notification to all devices subscribed to the topic. The project also includes the functionality to send and receive notifications within a Flutter application.
User Interface: The application includes two text fields: one for the notification title and one for the notification body. The user can enter the details and click the "Send" button to send the notification to all devices subscribed to the topic.

Notification Handling: When a device receives a notification (remote message), the message is stored in Firestore. The application then retrieves these messages from Firestore and displays them in the UI.

