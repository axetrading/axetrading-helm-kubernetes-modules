loki:
  schemaConfig:
    configs:
      - from: 2024-04-01
        store: tsdb
        object_store: ${loki_object_store_type}
        schema: v13
        index:
          prefix: index_
          period: 24h