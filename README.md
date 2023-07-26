# xair

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Publishing using nginx
- Install Nginx web server
```bash
sudo apt-get install nginx
```
- Controlling Nginx
This will start Nginx
```bash
sudo apt-get install nginx
```

To stop Nginx
```bash
sudo systemctl stop nginx
```

To restart Nginx
```bash
sudo systemctl restart nginx
```

To reload Nginx configurations.
```bash
sudo systemctl reload nginx
```
- Firewall
Your server should be running a firewall
```bash
sudo ufw allow 'Nginx Full'
```

Then we need to reload the firewall rules.
```bash
sudo ufw reload
```

- Make a Dummy Site
serve files from a directory within my home directory. This directory will be called `www`.
```bash
cd ~
mkdir www
```
In this new directory we will put all flutter project files.
Then we need to change the www directory permissions. This will allow Nginx to access the files.
```bash
chmod 0755  ~/www
```
- Nginx Configuration Directory
```bash
cd /etc/nginx
```

`Resource URL`:
https://medium.com/@jasonrigden/how-to-host-a-static-website-with-nginx-8b2dd0c5b301
