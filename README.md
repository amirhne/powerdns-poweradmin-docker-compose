# **PowerDNS with Poweradmin Docker Compose**

This project was driven by my personal enthusiasm to implement PowerDNS as the backbone DNS server in my production infrastructure. The environment included multiple Windows Server DNS servers as well as several BIND servers.

I utilized this project to manage multiple master zones in Active Directory, while also configuring PowerDNS to act as the authoritative master for other zones. The integration of PowerDNS allowed for centralized and efficient DNS management across diverse platforms.

## How it works?

The project involves four container instances, which include PowerDNS Recursor, PowerDNS Authoritative Server, the PowerAdmin PHP web GUI, and MySQL. A custom network was created for the setup, with only the PowerDNS Recursor and PowerAdmin GUI exposed externally. The remaining services, including the authoritative PowerDNS server and MySQL, are kept internal for security and performance reasons.

A custom Dockerfile was created specifically for the PowerAdmin instance. This [Poweradmin](https://github.com/poweradmin/poweradmin) must be cloned into the `www` folder of the project directory to ensure proper configuration and functionality.

## How to Run it?

Start by cloning the repository that contains the Docker Compose configuration for PowerDNS and PowerAdmin.
```
 git clone https://github.com/amirhne/powerdns-poweradmin-docker-compose.git
```
Next, create the necessary directory for **PowerAdmin** inside the cloned repository and clone the **PowerAdmin** repository into it.
```
mkdir powerdns-poweradmin-docker-compose/poweradmin/www
git clone https://github.com/poweradmin/poweradmin.git powerdns-poweradmin-docker-compose/poweradmin/www
```
If you have your own **SSL certificate** for the PowerAdmin interface, place public and private key with the same name in the `ssl` directory inside `powerdns-poweradmin-docker-compose/poweradmin/ssl`

Customize the recursor.conf file to suit your zone configuration, ensuring not to change the IP address 172.28.0.4 for the PowerDNS Authoritative Server (used for forwarding requests), but replace the IPs for other master zones handled by external DNS servers like Windows Server DNS or BIND with their respective addresses.

You can find the configuration file here:
[recursor.conf](https://github.com/amirhne/powerdns-poweradmin-docker-compose/blob/main/recursor/recursor.conf).

Also, **replace 'scure-db-pass'** in both the [docker-compose.yml](https://github.com/amirhne/powerdns-poweradmin-docker-compose/blob/main/docker-compose.yml) and [pdns.conf](https://github.com/amirhne/powerdns-poweradmin-docker-compose/blob/main/auth/pdns.conf) files. This is the password used to connect Poweradmin to MySQL.

Once everything is configured, use Docker Compose to bring up the services. The `-d` flag runs the containers in the background.
```
cd powerdns-poweradmin-docker-compose/
docker compose up -d
```
After the containers start, you can access **PowerAdmin** via the following URLs:

- **HTTP**: http://127.0.0.1
- **HTTPS**: https://127.0.0.1

You may need to adjust your browser's security settings if you're using a self-signed certificate for HTTPS. Once the **PowerAdmin** web interface loads, complete the **startup wizard**.

Follow the instructions to set up the PowerAdmin interface and connect it to your PowerDNS instance. Use 'pdns-mysql' as the database address, 'root' as the database user, and 'pdns' as the database name.

After completing the setup wizard:

- **Modify the `www` directory** for any custom changes that Poweradmin whats you to apply.
- **Import the PowerDNS SQL schema** into the MySQL container to ensure everything works properly.

```
docker exec -i pdns-mysql mysql -u root -p < /path/to/powerdns-schema.sql
```

Finally, to secure PowerDNS, I recommend allowing only TCP/UDP port 53 to the node and restricting access to TCP ports 80/443 to authorized devices only. Additionally, I suggest using a separate SQL user with full access to the PowerDNS database in the [pdns.conf](https://github.com/amirhne/powerdns-poweradmin-docker-compose/blob/main/auth/pdns.conf) file.
