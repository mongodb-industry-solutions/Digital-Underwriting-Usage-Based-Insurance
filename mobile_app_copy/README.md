
# iOS Swift Sample IoT Device Controller App

## Download Xcode
[Download Xcode here.](https://developer.apple.com/xcode/)

## Update your Atlas App ID in the iOS mobile app

1. Open the Controller.xcodeproj with XCode
2. Open the config file  ```./mobile-swift/Controller/Config.xcconfig```
3. Update ```Atlas_App_ID = <-- Your Atlas App ID -->```

## In MongoDB Atlas

### 1. App Services / Functions 
Click on create new function and call it “resetFunc”, paste code the following code:

```
/*
    This function will be run when the client SDK 'callResetPasswordFunction' is called with an object parameter that
    contains five keys: 'token', 'tokenId', 'username', 'password', and 'currentPasswordValid'.
    'currentPasswordValid' is a boolean will be true if a user changes their password by entering their existing
    password and the password matches the actual password that is stored. Additional parameters are passed in as part
    of the argument list from the SDK.

    The return object must contain a 'status' key which can be empty or one of three string values:
      'success', 'pending', or 'fail'

    'success': the user's password is set to the passed in 'password' parameter.

    'pending': the user's password is not reset and the UserPasswordAuthProviderClient 'resetPassword' function would
      need to be called with the token, tokenId, and new password via an SDK. (see below)

      const Realm = require("realm");
      const appConfig = {
          id: "my-app-id",
          timeout: 1000,
          app: {
              name: "my-app-name",
              version: "1"
          }
        };
      let app = new Realm.App(appConfig);
      let client = app.auth.emailPassword;
      await client.resetPassword(token, tokenId, newPassword);

    'fail': the user's password is not reset and will not be able to log in with that password.

    If an error is thrown within the function the result is the same as 'fail'.

    Example below:

    exports = ({ token, tokenId, username, password, currentPasswordValid }, sendEmail, securityQuestionAnswer) => {
      // process the reset token, tokenId, username and password
      if (sendEmail) {
        context.functions.execute('sendResetPasswordEmail', username, token, tokenId);
        // will wait for SDK resetPassword to be called with the token and tokenId
        return { status: 'pending' };
      } else if (context.functions.execute('validateSecurityQuestionAnswer', username, securityQuestionAnswer || currentPasswordValid)) {
        // will set the users password to the password parameter
        return { status: 'success' };
      }

      // will not reset the password
      return { status: 'fail' };
    };

    The uncommented function below is just a placeholder and will result in failure.
  */

  exports = ({ token, tokenId, username, password }) => {
    // will not reset the password
    return { status: 'fail' };
  };
```

Click on review draft and deploy

### 2. App Services / Authentication

Click on enable email/password authentication. Select password reset method, select the function you just created "resetFunc". Like so: 

!(https://github.com/mongodb-industry-solutions/Digital-Underwriting-Usage-Based-Insurance/blob/main/src/authentication.png)

Click on review draft and deploy 

### 3. App Services / Users

Click on a dd new user, enter the following: email: *demo* and password: *demopw*. Once the user is created make a copy of the **app user ID**.

### 4. Data Services / Browse Collections

Go into the digital_underwriting/customer collection:
* Click on insert document
* Copy all of the fields from the original document
* Change _id & customerId from type ObjectId to String
* Paste your **app user ID** in _id and customerID

Go to the digital_underwriting/customerPolicy collection:
* Change customerId from type ObjectId to String
* Paste your **app user ID** 

### 5. App Services / Schema

Go into the digital_underwriting/customer collection, click on define a schema and then generate schema from sampling.
* Change _id & customerId bsonType from ObjectId to String
* Click on review draft and deploy

Go into the digital_underwriting/customerPolicy collection, click on define a schema and then generate schema from sampling.
* Change customerId bsonType from ObjectId to String
* Click on review draft and deploy
* Click “Add relationship” and add the following: 

!(https://github.com/mongodb-industry-solutions/Digital-Underwriting-Usage-Based-Insurance/blob/main/src/relationship.png)

* Click on review draft and deploy

### 6. App Services / Rules

For both Customer and CustomerPolicy collections, click on allow all read and write. Then, click on review draft and deploy.

### 7. App Services / Device Sync

Click on enable sync. Make sure development mode is turned on. Add the following queryable fields: _id, customerid, firstName, lastName, policyNumber. Then, click on review draft and deploy.

## Run the iOS mobile app

In Xcode, click on the play button.


