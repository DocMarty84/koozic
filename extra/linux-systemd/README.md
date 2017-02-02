This folder provides examples for system and user configurations for systemd. System units are
loaded at startup, while user units are loaded when user logs in. System units are therefore
recommended for the use of KooZic on a server.

Only one process should be started for the whole system.

# System units

As root:

- Copy the file `system/koozic@.service` to `/etc/systemd/system`.
- Adapt the `ExecStart` setting to your configuration.
- Enable the service: `systemctl enable koozic@<your_user>.service`, where `<your_user>` must be
  replaced by the user who runs KooZic.
- Start the service: `systemctl start koozic@<your_user>.service`
- Check the status: `systemctl status koozic@<your_user>.service`

# User units

Several options are available, here is one which doesn't require root access.

As the user who runs Koozic:

- Copy the file `user/koozic.service` to `~/.config/systemd`.
- Adapt the `ExecStart` setting to your configuration.
- Enable the service: `systemctl enable koozic.service`
- Start the service: `systemctl start koozic.service`
- Check the status: `systemctl status koozic.service`
