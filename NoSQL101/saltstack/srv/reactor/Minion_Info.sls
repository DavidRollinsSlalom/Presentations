{% if 'present' in data %}
get_minion_info:
  runner.minion_status.get_minion_info:
    - minions: {{ data['present'] }}
    - checkin: {{ data['_stamp'] }}
    - presence: 'present'
{% endif %}
