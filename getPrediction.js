exports = async function(changeEvent){
  
  const {updateDescription, fullDocument} = changeEvent;
  var collection = context.services.get("mongodb-atlas").db("digital_underwriting").collection("customerTripMonthly");
  var policy_coll = context.services.get("mongodb-atlas").db("digital_underwriting").collection("customerPolicy");
  var policyDoc = await policy_coll.findOne({"customerId": fullDocument.customerId});
  const totalDistance = parseFloat(fullDocument.totalDistance);
  const basePremium = parseFloat(policyDoc.baseMonthlyPremium);
  
  var unirest = require('unirest');
  var req = unirest('POST', 'https://dbc-ca6bc27a-67f7.cloud.databricks.com/model/premium_calculator_w_baseline/3/invocations')
  .headers({
    'Authorization': 'Basic bHVjYS5uYXBvbGlAbW9uZ29kYi5jb206THVjYXRlc3QwLg==',
    'Content-Type': 'application/json'
  })
  .send(JSON.stringify({"inputs": [totalDistance, basePremium]}))
  .end(function (res) { 
    if (res.error) throw new Error(res.error); 
    
    let calculated_premium = JSON.parse(res.raw_body).predictions;
    collection.updateOne({"_id": fullDocument._id}, {$set:{"calculatedPremium": calculated_premium}} );
  });
  
 };
