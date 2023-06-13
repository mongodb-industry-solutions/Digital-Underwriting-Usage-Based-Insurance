# Step 5: Setting up the Databricks configuration 
The total distance and baseline premium is sent to Databricks for ML prediction. For ease of purposes, we’ve included the [API call](pipeline_unirest.js) that easily allows you to connect to your ML model. Although we’ve decided to use Databricks, you are free to use any ML platform of your choice. 

We include the code we used for the Databricks model (extremely basic):

import mlflow

class MyModelWBaseline(mlflow.pyfunc.PythonModel):
    def predict(self, context, model_input):
        return self.my_custom_function(model_input)

    def my_custom_function(self, model_input):
        # do something with the model input
        return model_input[0] + model_input[1]*0.1
        
# save the model
my_model = MyModelWBaseline()
with mlflow.start_run():
    model_info = mlflow.pyfunc.log_model(artifact_path="model", python_model=my_model)

In [Step 6](Prediction.md), we will write the ML prediction to MongoDB. 
