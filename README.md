# **PowerDNS with Poweradmin Docker Compose**

This project was driven by my personal enthusiasm to implement PowerDNS as the backbone DNS server in my production infrastructure. The environment included multiple Windows Server DNS servers as well as several BIND servers.

I utilized this project to manage multiple master zones in Active Directory, while also configuring PowerDNS to act as the authoritative master for other zones. The integration of PowerDNS allowed for centralized and efficient DNS management across diverse platforms.

## How it works?

The project involves four container instances, which include PowerDNS Recursor, PowerDNS Authoritative Server, the PowerAdmin PHP web GUI, and MySQL. A custom network was created for the setup, with only the PowerDNS Recursor and PowerAdmin GUI exposed externally. The remaining services, including the authoritative PowerDNS server and MySQL, are kept internal for security and performance reasons.

A custom Dockerfile was created specifically for the PowerAdmin instance. This [Poweradmin](https://github.com/poweradmin/poweradmin) must be cloned into the `www` folder of the project directory to ensure proper configuration and functionality.
