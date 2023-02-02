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
      'viewUpdateTimestamp': new Date('Thu, 02 Feb 2023 16:28:44 GMT')
    }
  }, {
    '$replaceRoot': {
      'newRoot': {
        'customerId': '$_id.customerId', 
        'year': '$_id.year', 
        'month': '$_id.month', 
        'totalDistance': '$totalDistance', 
        'viewUpdateStamp': '$viewUpdateTimestamp'
      }
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
