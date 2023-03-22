{{/*
Create image tag.
*/}}
{{- define "generate.image" -}}
{{-   $repository := default .Chart.Name .Values.image.repository | toString -}}
{{-   $defaultTag := "latest" -}}
{{-   if .Chart.AppVersion -}}
{{-     $defaultTag = .Chart.AppVersion -}}
{{-   end -}}
{{-   $tag := default $defaultTag .Values.image.tag | toString -}}
{{-   if .Values.image.name  -}}
{{-     printf "%s/%s:%s" $repository .Values.image.name $tag -}}
{{-   else -}}
{{-     printf "%s:%s" $repository $tag -}}
{{-   end -}}
{{- end -}}
