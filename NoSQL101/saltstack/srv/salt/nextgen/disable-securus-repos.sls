Disable securus.repo:
  file.rename:
    - name: /etc/yum.repos.d/securus.repo.disabled
    - source: /etc/yum.repos.d/securus.repo
    - force: True