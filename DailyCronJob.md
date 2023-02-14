# Step 2: Setting up a Daily Cron Job

After you’ve loaded your sample data in MongoDB Atlas, you’ll set up a [daily cron job](https://www.mongodb.com/docs/atlas/triggers/cron-expressions/). Whenever all of the fields in a CRON expression match the current date and time, Atlas fires the trigger associated with the expression.  
* Navigate to App Services and click on “Triggers”. 
* Add a Trigger. 
* Select a [Scheduled Trigger type](https://www.mongodb.com/docs/atlas/app-services/triggers/scheduled-triggers/) as seen in the figure below.

![image](InsuranceGitHub/Figure3.png)
* Name it.
* Click the “Advanced” button and under “Set a CRON schedule” input the desired daily time. In our case it is midnight. This ensures that every day at midnight the dailyAggregationPipeline function is triggered, which aggregates all of the daily trips into a new document that summarizes the distances driven during that day. 
* Click the “Function” button as seen in the figure below and select the [dailyAggregationPipeline function](MaterializedViews/DailySummary).

![image](InsuranceGitHub/Figure4.png)

At midnight everyday, a new collection called “customerTripDaily” will be added in your Atlas Data Services collection. All of the daily documents will now be stored in the "customerTripDaily" collection as seen in the figure below. 

![image](InsuranceGitHub/Figure5.png) 

If you click into your "customerTripDaily" collection, you should see a similar daily document as in the figure below. 

![image](Figure66) 

Congrats on setting up a daily cron job! Now we'll do the same process for setting up a monthly cron job in [Part 3](MonthlyCronJob.md). 
