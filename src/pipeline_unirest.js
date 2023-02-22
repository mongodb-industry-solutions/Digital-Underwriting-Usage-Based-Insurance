exports = async function(changeEvent){
  
  const {updateDescription, fullDocument} = changeEvent;
  var collection = context.services.get("mongodb-atlas").db("digital_underwriting").collection("customerTripMonthly");
  const policy_coll = context.services.get("mongodb-atlas").db("digital_underwriting").collection("customerPolicy");
  const totalDistance = parseFloat(fullDocument.totalDistance);
  const policyDoc = await policy_coll.findOne({"customerId": fullDocument._id.customerId});
  const basePremium = parseFloat(policyDoc.baseMonthlyPremium);
  
  var unirest = require('unirest');
  var req = unirest('POST', 'https://dbc-ca6bc27a-67f7.cloud.databricks.com/serving-endpoints/luca/invocations')
  .headers({
    'Authorization': 'Basic bHVjYS5uYXBvbGlAbW9uZ29kYi5jb206THVjYXRlc3QwLg==',
    'Content-Type': 'application/json'
  })
  .send(JSON.stringify({"inputs": [basePremium, totalDistance]}))
  .end(function (res) { 
    if (res.error) throw new Error(res.error); 
    
    let calculated_premium = JSON.parse(res.raw_body).predictions;
    const month = fullDocument._id.month;
    policy_coll.updateOne({"_id":policyDoc._id}, {$push:{"premium":{"month":month,"calculatedPremium": calculated_premium}}});
    
  });
  
 };
