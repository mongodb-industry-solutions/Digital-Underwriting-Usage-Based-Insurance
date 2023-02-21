# Step 6: ML Prediction is written to MongoDB 
Once your Databricks ML model has completed running, the “pipeline_unirest” function we’ve set up earlier ensures that the new calculated premium is written back to MongoDB. 
* Navigate to Data Services and to your collection. 
* Navigate to “customerTripMonthly”. There you’ll find the new calculated premium as seen in the figure below.

![image](InsuranceGitHub/Figure12.png) 

And that’s a wrap! 
Within the following 6 simple steps you were able to create an automatic data-driven insurance premium for connected cars.
* [Step 1: Load the Sample Data](LoadingtheSampleData.md)
* [Step 2: Set up a Daily Cron Job](DailyCronJob.md) 
* [Step 3: Set up a Monthly Cron Job](MonthlyCronJob.md) 
* [Step 4: Set up a "Calculate Premium" Trigger](CalculatePremiumTrigger.md)
* [Step 5: Set up the Databricks configuration](DatabricksConfiguration.md) 
* [Step 6: Write the ML Prediction to MongoDB](Prediction.md) 

If you're interested in visualizing your data, check out the [bonus section](DataVisualization.md)! 
