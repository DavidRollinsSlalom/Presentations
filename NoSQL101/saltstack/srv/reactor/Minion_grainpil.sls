{% if 'present' in data %}
set_pillar_grain_info:
  runner.minion_grain_pils.set_min_pillgrains:
    - minions: {{ data['present'] }}
{% endif %}
