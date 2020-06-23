# Elasticsearch

## Directories

```console
/usr/local/Cellar/elasticsearch/7.6.2/libexec/logs
/usr/local/Cellar/elasticsearch/7.6.2/libexec/conf
/usr/local/Cellar/elasticsearch/7.6.2/libexec
```

## Start

```console
elasticsearch-start
```

## Stop

```console
elasticsearch-stop
```

## Restart

```console
elasticsearch-restart
```

## Validate in browser

http://localhost:9200

```console
{
  "name" : "macbook-pro-user",
  "cluster_name" : "elasticsearch_brew",
  "cluster_uuid" : "lq8jFgJ1QB6gBI8ooyygSA",
  "version" : {
    "number" : "7.6.2-SNAPSHOT",
    "build_flavor" : "oss",
    "build_type" : "tar",
    "build_hash" : "unknown",
    "build_date" : "2020-06-09T10:45:50.727176Z",
    "build_snapshot" : true,
    "lucene_version" : "8.4.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```
