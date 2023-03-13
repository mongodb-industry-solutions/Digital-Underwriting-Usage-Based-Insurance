exports = async function(changeEvent){


  const ENDPOINT_URL = 'https://dbc-ca6bc27a-67f7.cloud.databricks.com/serving-endpoints/luca/invocations'
  const AUTH_TOKEN = "Basic bHVjYS5uYXBvbGlAbW9uZ29kYi5jb206THVjYXRlc3QwLg=="
  
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