# Inception_42

This assignment is a comprehensive system administration exercise designed to enhance your knowledge and practical skills using Docker. Here’s a summary highlighting the key technological lessons you will learn:

# Technological Lessons
Virtualization and Docker Basics:

# Understanding Docker and its role in virtualization.
Creating and managing Docker images and containers.
Docker Compose:

Using Docker Compose to define and run multi-container Docker applications.
Building Docker images using docker-compose.yml and a Makefile.
Service Management:

Setting up and configuring various services (NGINX, WordPress, MariaDB) in separate Docker containers.
Ensuring each service runs in a dedicated container and configuring them to restart on crash.
Dockerfile Creation:

Writing custom Dockerfiles for each service.
Learning best practices for Dockerfile creation, including avoiding common pitfalls like infinite loops.
Networking and Volumes:

Setting up Docker networks to connect containers.
Configuring Docker volumes for persistent storage of database and website files.
Security and Environment Variables:

Managing environment variables and secrets securely.
Storing sensitive information like passwords in .env files and using Docker secrets.
TLS Configuration:

Configuring NGINX to use TLSv1.2 or TLSv1.3 for secure communication.
Ensuring that NGINX is the sole entry point to the infrastructure via port 443.
Domain Name Configuration:

Setting up a local domain name (e.g., login.42.fr) to point to the virtual machine’s IP address.
User Management in WordPress:

Setting up WordPress with a database, including creating two users and managing user roles and permissions.
Bonus Technological Lessons
If you complete the mandatory part perfectly, you can explore the following advanced topics:

Redis Cache:

Setting up Redis to optimize WordPress caching.
FTP Server:

Configuring an FTP server container linked to WordPress website volume.
Static Website:

Creating a simple static website using a language other than PHP.
Adminer:

Setting up Adminer for database management.
Custom Service:

Implementing an additional service of your choice, justifying its usefulness and integration.
Skills Development
By completing this project, you will gain hands-on experience with:

Docker and containerization.
Network and volume management in Docker.
Securely managing environment variables and secrets.
Configuring web servers and database servers.
Implementing TLS security.
Automating setup processes with Makefile and Docker Compose.
This assignment provides a practical, in-depth understanding of deploying and managing containerized applications, which is highly valuable for modern system administration and DevOps roles.
