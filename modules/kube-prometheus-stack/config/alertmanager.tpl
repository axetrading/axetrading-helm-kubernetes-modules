alertmanager:
  config:
    global:
      resolve_timeout: 1m
      slack_api_url: ${slack_api_url}
      pagerduty_url: ${pagerduty_url}
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
      repeat_interval: 6h
      receiver: 'slack'
      routes:
      - receiver: 'null'
        matchers:
          - alertname =~ "InfoInhibitor|Watchdog"
      - receiver: 'slack'
        matchers:
            - severity =~ "warning|critical"
      - receiver: 'pagerduty'
        matchers:
            - severity =~ "warning|critical"
    receivers:
    - name: 'null'
    - name: 'pagerduty'
      pagerduty_configs:
      - service_key: ${pagerduty_service_key}
    - name: 'slack'
      slack_configs:
      - channel: '#${slack_channel}'
        send_resolved: true
        title: '{{ template "slack.devops.title" . }}'
        text: '{{ template "slack.devops.text" . }}'
        icon_emoji: '{{ template "slack.devops.icon_emoji" . }}'
        color: '{{ template "slack.devops.color" . }}'
        actions:
        - type: button
          name: runbook
          text: 'Runbook :green_book:'
          url: '{{ (index .Alerts 0).Annotations.runbook_url }}'
        - type: button
          name: query
          text: 'Query :mag:'
          url: '{{ (index .Alerts 0).GeneratorURL }}'
        - type: button
          name: dashboard
          text: 'Dashboard :grafana:'
          url: '{{ (index .Alerts 0).Annotations.dashboard }}'
        - type: button
          name: silence
          text: 'Silence :no_bell:'
          url: '{{ template "__alert_silence_link" . }}'
    templates:
    - '/etc/alertmanager/config/*.tmpl'

  templateFiles: 
    alerts.tmpl: |-
         {{ define "__alert_silence_link" -}}
             {{ .ExternalURL }}/#/silences/new?filter=%7B
             {{- range .CommonLabels.SortedPairs -}}
                 {{- if ne .Name "alertname" -}}
                     {{- .Name }}%3D"{{- .Value -}}"%2C%20
                 {{- end -}}
             {{- end -}}
             alertname%3D"{{ .CommonLabels.alertname }}"%7D
         {{- end }}
         
         {{ define "__alert_severity_prefix" -}}
             {{ if ne .Status "firing" -}}
             :ok:
             {{- else if eq .Labels.severity "critical" -}}
             :fire:
             {{- else if eq .Labels.severity "warning" -}}
             :warning:
             {{- else -}}
             :question: 
             {{- end }}
         {{- end }}
         
         {{ define "__alert_severity_prefix_title" -}}
             {{ if ne .Status "firing" -}}
             :ok:
             {{- else if eq .CommonLabels.severity "critical" -}}
             :fire:
             {{- else if eq .CommonLabels.severity "warning" -}}
             :warning:
             {{- else if eq .CommonLabels.severity "info" -}}
             :information_source:
             {{- else -}}
             :question: {{ .CommonLabels.severity }}
             {{- end }}
         {{- end }}
         
         {{ define "slack.devops.title" -}}
             [{{ .Status | toUpper -}}
             {{ if eq .Status "firing" }}:{{ .Alerts.Firing | len }}{{- end -}}
             ] {{ template "__alert_severity_prefix_title" . }} {{ .CommonLabels.alertname }}
         {{- end }}
         
         {{ define "slack.devops.color" -}}
             {{ if eq .Status "firing" -}}
                 {{ if eq .CommonLabels.severity "warning" -}}
                     warning
                 {{- else if eq .CommonLabels.severity "critical" -}}
                     danger
                 {{- else -}}
                     #439FE0
                 {{- end -}}
             {{ else -}}
             good
             {{- end }}
         {{- end }}
         
         {{ define "slack.devops.icon_emoji" }}:prometheus:{{ end }}
         
         {{ define "slack.devops.text" -}}
           *Alert:* {{ .CommonAnnotations.summary }} - `{{ .CommonLabels.severity }}`
           *Cluster:* {{ .CommonLabels.cluster }}
           *Description:* {{ .CommonAnnotations.description }}
           *Details:*
             {{ range .CommonLabels.SortedPairs }} - *{{ .Name }}:* `{{ .Value }}`
             {{ end }}
         {{- end }}