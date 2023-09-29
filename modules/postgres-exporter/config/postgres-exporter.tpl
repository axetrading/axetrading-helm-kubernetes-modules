config:
  datasourceSecret:
    name: ${datasources_secret_name}
    key: ${datasources_secret_key}
    csi:
      secretProviderClass:
        provider: aws
        secretObjects:
        - data:
          - key:  ${datasources_secret_key}
            objectName: ${datasources_secret_name}
          secretName: ${datasources_secret_name}
          type: Opaque
        parameters:
          objects: |
            - objectName: ${datasources_secret_name}
              objectAlias: ${datasources_secret_name}
              objectType: "secretsmanager"
