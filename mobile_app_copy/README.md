
# iOS Swift Sample IoT Device Controller App

## Download Xcode
[Download Xcode here.](https://developer.apple.com/xcode/)

## Update your Atlas App ID in the iOS mobile app

1. Open the Controller.xcodeproj with XCode
2. Open the config file  ```./mobile-swift/Controller/Config.xcconfig```
3. Update ```Atlas_App_ID = <-- Your Atlas App ID -->```

## In MongoDB Atlas

1. Go into Functions 
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

