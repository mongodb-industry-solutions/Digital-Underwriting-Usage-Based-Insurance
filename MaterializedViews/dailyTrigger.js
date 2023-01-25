exports = function() {

const agg = [
  {
    '$project': {
      'date': {
        '$dateToParts': {
          'date': '$timestamp'
        }
      }, 
      'customerId': 1, 
      'milesDriven': 1, 
      'maxSpeed': 1, 
      'speedUnit': 1
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
      'averageDistance': {
        '$avg': '$milesDriven'
      }, 
      'totalDistance': {
        '$sum': '$milesDriven'
      }
    }
  }, {
    '$project': {
      'customerId': '$_id.customerId', 
      'year': '$_id.date.year', 
      'month': '$_id.date.month', 
      'day': '$_id.date.day', 
      'averageDistance': 1, 
      'totalDistance': 1, 
      '_id': 1
    }
  }, {
    '$addFields': {
      'updateTimestamp': new Date()
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

};
