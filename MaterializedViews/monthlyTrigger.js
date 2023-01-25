exports = function() {

const agg = [
  {
    '$group': {
      '_id': {
        'year': '$year', 
        'month': '$month', 
        'customerId': '$customerId'
      }, 
      'averageDistance': {
        '$avg': '$averageDistance'
      }, 
      'totalDistance': {
        '$sum': '$totalDistance'
      }
    }
  }, {
    '$project': {
      'year': '$_id.year', 
      'month': '$_id.month', 
      'customerId': '$_id.customerId', 
      'averageDistance': 1, 
      'totalDistance': 1
    }
  }, {
    '$addFields': {
      'updateTimestamp': new Date()
    }
  }, {
    '$merge': {
      'into': 'customerTripMonthly', 
      'whenMatched': 'replace'
    }
  }
];

const coll = context.services.get("mongodb-atlas").db('digital_underwriting').collection('customerTripDaily');

const cursor = coll.aggregate(agg);

  
};
