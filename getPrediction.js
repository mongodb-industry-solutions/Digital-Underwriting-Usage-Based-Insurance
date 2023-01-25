exports = function(changeEvent){
  
  const {updateDescription, fullDocument} = changeEvent;
  var collection = context.services.get("mongodb-atlas").db("digital_underwriting").collection("customerTripMonthly");
  
  var unirest = require('unirest');
  var req = unirest('POST', '<model endpoint address>')
  .headers({
    'Authorization': 'Basic <credentials>',
    'Content-Type': 'application/json'
  })
  .send(JSON.stringify({
    "inputs": [
      [
        fullDocument.totalDistance
      ]
    ]
  }))
  .end(function (res) { 
    if (res.error) throw new Error(res.error); 
    
    calculated_premium = JSON.parse(res.raw_body).predictions[0][0];
    collection.updateOne({"_id": fullDocument._id}, {$set:{"calculatedPremium": calculated_premium}} );
  });
  
};
