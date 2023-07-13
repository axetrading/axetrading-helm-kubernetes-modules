alertmanager:
  config:
    global:
      resolve_timeout: 1m
      slack_api_url: ${slack_api_url}
    inhibit_rules:
      - source_matchers:
          - 'severity = critical'
        target_matchers:
          - 'severity =~ warning|info'
        equal:
          - 'namespace'
          - 'alertname'
      - source_matchers:
          - 'severity = warning'
        target_matchers:
          - 'severity = info'
        equal:
          - 'namespace'
          - 'alertname'
      - source_matchers:
          - 'alertname = InfoInhibitor'
        target_matchers:
          - 'severity = info'
        equal:
          - 'namespace'
    route:
      group_by: ['cluster', 'namespace']
      group_wait: 30s
      group_interval: 5m
      repeat_interval: 12h
      receiver: 'null'
      routes:
      - receiver: 'null'
        matchers:
          - alertname =~ "InfoInhibitor|Watchdog"
      - receiver: 'slack'
        matchers:
            - severity =~ "warning|critical"
    receivers:
    - name: 'null'
    - name: 'slack'
      slack_configs:
      - channel: '#monitoring'
        send_resolved: true
        text: '{{ template "slack.devops.text" . }}'
    templates:
    - '/etc/alertmanager/config/*.tmpl'

  templateFiles: 
    slack.tmpl: |-
         {{ define "cluster" }}{{ .ExternalURL | reReplaceAll ".*alertmanager\\.(.*)" "$1" }}{{ end }}
  
         {{ define "slack.devops.text" }}
         {{- $root := . -}}
         {{ range .Alerts }}
           *Alert:* {{ .Annotations.summary }} - `{{ .Labels.severity }}`
           *Cluster:* {{ template "cluster" $root }}
           *Description:* {{ .Annotations.description }}
           *Graph:* <{{ .GeneratorURL }}|:chart_with_upwards_trend:>
           *Runbook:* <{{ .Annotations.runbook }}|:spiral_note_pad:>
           *Details:*
             {{ range .Labels.SortedPairs }} - *{{ .Name }}:* `{{ .Value }}`
             {{ end }}
         {{ end }}
         {{ end }}