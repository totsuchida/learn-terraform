# learn-terraform


## google_project_service の注意点
- destroyするとAPIが無効化される
  - `cloudresourcemanager.googleapis.com`が無効化されると、Terraformで何も操作できなくなるので定義から外した。
    - もともと定義していた場合は、外した時に無効化されてしまうため、手動で有効化すること。