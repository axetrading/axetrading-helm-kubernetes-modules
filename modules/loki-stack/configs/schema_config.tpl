configs:
  - from: 2022-01-11
    store: boltdb-shipper
    object_store: ${loki_object_store_type}
    schema: v12
    index:
      prefix: index_
      period: 24h
