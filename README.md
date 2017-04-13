# Apache Flume-NG image with S3 sink supporting

## Example
### run container
```
docker run -d --name flume-athena-agent -e FLUME_AGENT_NAME=athena -v `readlink -f configs/`:/conf -p 2140:2140 mpidlisnyi/flume
```

### uploading testing data
```
while :; do curl  -H "Content-Type:application/json"  localhost:2140 -d '[ { "headers" : { "host": "test-host1", "hive_path": "partition1=part1/partition2=part2/" }, "body" : "{\"id\": 1}" } ]'; done
```
