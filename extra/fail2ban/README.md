# Fail2ban

KooZic does not provide any embedded brute-force attack protection. Here is a guide to set up
fail2ban to mitigate such an attack.

- Copy the filter: `cp filter.local /etc/fail2ban/filter.d/koozic-login.local`
- Copy the jail: `cp jail.local /etc/fail2ban/jail.d/koozic-login.local`

The jail assumes KooZic is run thanks to systemd.

Restart the fail2ban service.
