exports = function() {

const agg = [
  {
    '$group': {
      '_id': {
        'year': '$year', 
        'month': '$month', 
        'customerId': '$customerId'
      }, 
      'totalDistance': {
        '$sum': '$totalDistance'
      }
    }
  }, {
    '$project': {
      'totalDistance': {
        '$round': [
          '$totalDistance', 1
        ]
      }
    }
  }, {
    '$addFields': {
      'viewUpdateTimestamp': new Date()
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
