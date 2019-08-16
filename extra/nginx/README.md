
# Nginx

A nginx configuration file is provided in order to activate the SSL encryption.

Copy the file `nginx_ssl_config` to `/etc/nginx/sites-available/default`. Change:
- `<your_domain>` to your own domain name.
- `ssl_certificate`, `ssl_certificate_key` and `ssl_dhparam` to your configuration.

Restart the service. To generate SSL certificates with Let's Encrypt, follow the instructions below.

# KooZic

When running behind nginx, KooZic requires an extra parameter. Add the option `--proxy-mode` at
execution. For example:
```
/opt/koozic/odoo-bin --workers=4 --limit-time-cpu=1800 --limit-time-real=3600 --proxy-mode
```

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

In the nginx configuration file, use the generated files as follow (use `fullchain.pem` and not
`cert.pem`):
```
ssl_certificate     /etc/letsencrypt/live/<your_domain>/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/<your_domain>/privkey.pem;
ssl_dhparam         /etc/nginx/dh4096.pem;
```

Restart the service.

## Auto renewal of certificate

Create a `cron` job (once a day) for the following command:
```
/path/to/certbot-auto renew --no-self-upgrade ; service nginx restart
```
