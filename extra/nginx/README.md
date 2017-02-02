
# Nginx

A nginx configuration file is provided in order to activate the SSL encryption.

Copy the file `nginx_ssl_config` to `/etc/nginx/sites-available/default`. Change:
- `<your_domain>` to your own domain name.
- `ssl_certificate`, `ssl_certificate_key` and `ssl_dhparam` to your configuration.

Restart the service. To generate SSL certificates with Let's Encrypt, follow the instructions below.

# Let's Encrypt

Here is the procedure to generate a Let's Encrypt SSL certificate

## Certificate generation

Get the code:
```
git clone https://github.com/certbot/certbot
```
Generate the certificates:
```
cd certbot
./certbot-auto certonly -d <your_domain> --rsa-key-size 4096
```
The certificates sould be created in `/etc/letsencrypt/live/<your_domain>`.

For an additional security level, generate the Diffie-Hellman parameter (this takes time...):
```
openssl dhparam -out dh4096.pem 4096
mv dh4096.pem /etc/nginx/
```

In the nginx configuration file, use the generated files as follow:
```
ssl_certificate     /etc/letsencrypt/live/<your_domain>/cert.pem;``
ssl_certificate_key /etc/letsencrypt/live/<your_domain>/privkey.pem;
ssl_dhparam         /etc/nginx/dh4096.pem;
```

Restart the service.

## Auto renewal of certificate

Create a `cron` job (once a day) for the following command:
```
/path/to/certbot-auto renew --no-self-upgrade ; service nginx restart
```

# Fail2ban

KooZic does not provide any embedded brute-force attack protection. Here is a guide to set up
fail2ban to mitigate such an attack when nginx is set up.

- Copy the filter: `cp fail2ban-filter.conf /etc/fail2ban/filter.d/nginx-odoo.conf`
- Copy the jail: `cp fail2ban-jail.conf /etc/fail2ban/jail.d/nginx-odoo.conf`

Restart the service.

Unfortunately, it is not possible to distinguish a successful from a failed login attempt.
Therefore, the jail is empirical and bans an IP address if more than 10 attempts are made within 120
seconds. In case many users connect to the server from the same IP address, this might be too
restrictive.
