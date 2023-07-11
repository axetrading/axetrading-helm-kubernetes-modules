type: s3
config:
  bucket: ${thanos_objstore_bucket}
  endpoint: ${thanos_objstore_endpoint}
  region: ${thanos_objstore_region}
  aws_sdk_auth: true
  insecure: false