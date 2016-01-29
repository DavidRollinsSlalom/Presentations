highstate_run:
  local.state.highstate:
    - tgt: {{ data['id'] }}

refresh_pillars:
  local.saltutil.refresh_pillar:
    - tgt: {{ data['id'] }}
