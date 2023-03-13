source credentials.sh

  curl --user "$PUBKEY:$PRIVKEY" --digest \
     --header "Content-Type: application/json" \
     --include \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/clusters?pretty=true" \
     --data '
       {
         "name": "insuranceDemo",
         "diskSizeGB": 10,
         "numShards": 1,
         "providerSettings": {
           "providerName": "AWS",
           "instanceSizeName": "M10",
           "regionName": "EU_WEST_1"
         },
         "clusterType" : "REPLICASET",
         "replicationFactor": 3,
         "replicationSpecs": [{
           "numShards": 1,
           "regionsConfig": {
             "EU_WEST_3": {
               "analyticsNodes": 0,
               "electableNodes": 3,
               "priority": 7,
               "readOnlyNodes": 0
             }
           },
           "zoneName": "Zone 1"
         }],
         "backupEnabled": false,
         "providerBackupEnabled" : true,
         "autoScaling": {
           "diskGBEnabled": true
         }
       }'

  echo "Cluster created; creating temp user"
  curl --digest --user "$PUBKEY:$PRIVKEY" -s -X POST -H "Content-Type: application/json" -d "{\"databaseName\":\"admin\",\"groupId\":\"$GROUPID\", \"roles\": [{\"databaseName\":\"admin\", \"roleName\":\"atlasAdmin\"}],\"username\":\"temp\",\"password\":\"temp\"}"  https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/databaseUsers
  curl --digest --user "$PUBKEY:$PRIVKEY" -s -X POST -H "Content-Type: application/json" -d '[{"ipAddress": "0.0.0.0"}]' https://cloud.mongodb.com/api/atlas/v1.0/groups/{$GROUPID}/accessList

  echo "waiting 15min before attempting restore"
  sleep 900

  connString=$(curl --digest --user "$PUBKEY:$PRIVKEY" -s -X GET -H "Content-Type: application/json" https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/clusters/insuranceDemo | jq -r ".connectionStrings.standardSrv")
  echo "Conn string is $connString"


  mongorestore --username temp --password temp $connString dump
  sleep 10
  echo "Data are restored. App is being created."

  realm-cli login --api-key="$PUBKEY" --private-api-key="$PRIVKEY"
  realm-cli push --local "./insuranceDemoApp"
  sleep 10
  echo "App is created."







