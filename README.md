# learn-terraform


## google_project_service の注意点
- destroyするとAPIが無効化される
  - `cloudresourcemanager.googleapis.com`が無効化されると、Terraformで何も操作できなくなるので定義から外した。