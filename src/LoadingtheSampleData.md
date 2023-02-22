# Step 1: Load the Sample Data

[Load the following sample data](https://www.mongodb.com/docs/guides/atlas/sample-data/) from our sample customer [“Eddie Grant”](Collections/Customer) into your [MongoDB Atlas account](https://account.mongodb.com/account/login).  

In your MongoDB Atlas cloud dashboard you should now see 3 collections as seen in the figure below: 
* [customer](Collections/Customer)
* [customerPolicy](Collections/Policy)
* [customerTripRaw](Collections/CustomerTripRaw)

![image](InsuranceGitHub/Figure2.png)

In a real-world scenario, insurers would most likely collect time-series data. However, for ease of demonstration, our sample data consists of all the trips taken during a 3-month time period. 

Now let's jump to [Step 2](DailyCronJob.md), where we'll set up a daily cron job. 
