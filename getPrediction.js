exports = async function(changeEvent){
  
  const {updateDescription, fullDocument} = changeEvent;
  var collection = context.services.get("mongodb-atlas").db("digital_underwriting").collection("customerTripMonthly");
  var policy_coll = context.services.get("mongodb-atlas").db("digital_underwriting").collection("customerPolicy");
  var policyDoc = await policy_coll.findOne({"customerId": fullDocument.customerId});
  const totalDistance = parseFloat(fullDocument.totalDistance);
  const basePremium = parseFloat(policyDoc.baseMonthlyPremium);
  
  var unirest = require('unirest');
  var req = unirest('POST', '<Model endpoint>')
  .headers({
    'Authorization': '<auth params>',
    'Content-Type': 'application/json'
  })
  .send(JSON.stringify({"inputs": [totalDistance, basePremium]}))
  .end(function (res) { 
    if (res.error) throw new Error(res.error); 
    
    let calculated_premium = JSON.parse(res.raw_body).predictions;
    collection.updateOne({"_id": fullDocument._id}, {$set:{"calculatedPremium": calculated_premium}} );
  });
  
 };
