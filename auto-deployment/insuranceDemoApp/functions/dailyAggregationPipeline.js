exports = async function() {

    const agg = [
  {
    '$project': {
      'date': {
        '$dateToParts': {
          'date': '$timestamp'
        }
      }, 
      'metadata': 1, 
      'milesDriven': 1, 
      'customerId': 1
    }
  }, {
    '$group': {
      '_id': {
        'date': {
          'year': '$date.year', 
          'month': '$date.month', 
          'day': '$date.day'
        }, 
        'customerId': '$customerId'
      }, 
      'totalDistance': {
        '$sum': '$milesDriven'
      }
    }
  }, {
    '$addFields': {
      'viewUpdateTimestamp': new Date()
    }
  }, {
    '$merge': {
      'into': 'customerTripDaily', 
      'whenMatched': 'replace'
    }
  }
];

    const coll = context.services.get("mongodb-atlas").db('digital_underwriting').collection('customerTripRaw');
    const cursor = coll.aggregate(agg);
    return cursor;

    };
