# Automated deployment for MongoDB Atlas

This is to create the MongoDB Atlas cluster, load data inside and create the app in app services.
The prerequiste here is to have created the model endpoint as this will be needed to create one of the app services function.

## Step 1 - Installations

Ensure you have npm, realm-cli and the mongodb tools.
The following lines about MongoDB tools are for Mac only. For other OS check the [documentation](https://www.mongodb.com/docs/database-tools/installation/installation/) 

```
npm install -g mongodb-realm-cli
brew tap mongodb/brew
brew install mongodb-database-tools
brew install jq
```

## Step 2 - Update Credentials file

Go to the Atlas UI, if you already have a project created, go to the project setting page. If not, create one and then click on project settings.
On the project setting page, copy your project ID and put it in **GROUPID** of the *credentials.sh* file.
Go to the access manager and click on API Keys.
Create a API with project owner permission and update the **PUBKEY** and **PRIVKEY** of the *credentials.sh* file with the API keys.

## Step 3 - Update the app services function

Once your model endpoint is created, open the [pipeline_unirest](insuranceDemoApp/functions/pipeline_unirest.js) function and update it with your **MODEL ENDPOINT** and its **CREDENTIALS**


## Step 4 - Execute the autodeployment script

Run the following command

```
./create-cluster.sh
```
The script will ask you to wait for 15 minutes for the cluster to be created before loading the data and creating the app. 
Then select all the default answers for the app creation and say **Yes** to allow the app creation

<img width="335" alt="Capture d’écran 2023-03-01 à 18 38 04" src="https://user-images.githubusercontent.com/33204364/222218559-42530fb3-0f3f-42bd-85fd-585820ebc603.png">

*If you have a permission denied error, try the following command to give execute permission and then run the previous one again*

```
chmod +x create-clusters.sh
```
## Step 5 - Enjoy !

You're all set ! Ready to demo !!

