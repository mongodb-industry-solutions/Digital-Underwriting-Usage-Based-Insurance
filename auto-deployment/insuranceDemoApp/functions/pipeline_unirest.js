exports = async function(changeEvent){

  //This two variables need to be edited, we added a dummy just for reference
  const ENDPOINT_URL = 'https://dbc-dhsaod789-309e7.cloud.databricks.com/serving-endpoints/endpointname/invocations'
  const AUTH_TOKEN = "Basic bkjsdhfdskuZ29kYi5jb206fhdsfkdshfkjs3QwLg=="
  
  const {updateDescription, fullDocument} = changeEvent;
 
  var collection = context.services.get("mongodb-atlas").db("digital_underwriting").collection("customerTripMonthly");
  const policy_coll = context.services.get("mongodb-atlas").db("digital_underwriting").collection("customerPolicy");
  
  const totalDistance = parseFloat(fullDocument.totalDistance);
  const policyDoc = await policy_coll.findOne({"customerId": fullDocument._id.customerId});
 
  
  const basePremium = parseFloat(policyDoc.baseMonthlyPremium);
  
  const data = {"inputs": [basePremium, totalDistance]}
  
  const res = await context.http.post({
    "url": ENDPOINT_URL,
    "body": JSON.stringify(data),
    "encodeBodyAsJSON": false,
    "headers": {
      "Authorization": [AUTH_TOKEN],
      "Content-Type": [ "application/json" ]
    }
  })

  
  let calculated_premium = EJSON.parse(res.body.text()).predictions;
  
  const month = fullDocument._id.month;
  policy_coll.updateOne({"_id":policyDoc._id}, {$push:{"premium":{"month":month,"calculatedPremium": calculated_premium}}});
  

 };
