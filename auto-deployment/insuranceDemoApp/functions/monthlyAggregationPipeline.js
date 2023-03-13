exports = async function() {

    const agg = [
  {
    '$group': {
      '_id': {
        'year': '$_id.date.year', 
        'month': '$_id.date.month', 
        'customerId': '$_id.customerId'
      }, 
      'totalDistance': {
        '$sum': '$totalDistance'
      }
    }
  }, {
    '$project': {
      '_id' : 1,
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
  }, 
  {
    '$merge': {
      'into': 'customerTripMonthly', 
      'whenMatched': 'replace'
    }
  }
];

    const coll = context.services.get("mongodb-atlas").db('digital_underwriting').collection('customerTripDaily');
    const cursor = coll.aggregate(agg);
    return cursor;
    };
