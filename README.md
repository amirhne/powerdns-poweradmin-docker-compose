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

Now, customize the `recursor.conf` file to suit your zone configuration. However, **do not change the IP address** `172.28.0.4` for master zones in Authoritative Server as it is required for forwarding request to master zone of PowerDNS.

You can find the configuration file here:
[recursor.conf](https://github.com/amirhne/powerdns-poweradmin-docker-compose/blob/main/recursor/recursor.conf).

the Docker networkEdit the configuration to reflect your **desired zone** settings, and put you Windows Server DNS or BIND.

Once everything is configured, use Docker Compose to bring up the services. The `-d` flag runs the containers in the background.

> docker compose up -d

After the containers start, you can access **PowerAdmin** via the following URLs:

- **HTTP**: http://127.0.0.1
- **HTTPS**: https://127.0.0.1

You may need to adjust your browser's security settings if you're using a self-signed certificate for HTTPS.Once the **PowerAdmin** web interface loads, complete the **startup wizard**.

Follow the instructions to set up the **PowerAdmin** interface and connect it to your PowerDNS instance.

After completing the setup wizard:

- **Modify the `www` directory** for any custom changes that Poweradmin whats you to apply.
- **Import the PowerDNS SQL schema** into the MySQL container to ensure everything works properly.

```
docker exec -i pdns-mysql mysql -u root -p < /path/to/powerdns-schema.sql
```
