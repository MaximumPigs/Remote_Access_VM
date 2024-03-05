#!/bin/bash

# Set VNC config

mkdir /home/ubuntu/.vnc
touch /home/ubuntu/.vnc/passwd
echo "Admin12!" | vncpasswd -f > /home/ubuntu/.vnc/passwd
echo "localhost" >> /etc/tigervnc/vncserver-config-mandatory
cp /lib/systemd/system/tigervncserver@.service /etc/systemd/system/tigervncserver@.service
echo ":1=ubuntu" >> /etc/tigervnc/vncserver.users
chown -R ubuntu:ubuntu /home/ubuntu/.vnc
chmod -R 600 /home/ubuntu/.vnc/passwd

# Reload systemctl daemons and start service

systemctl daemon-reload
systemctl enable tigervncserver@:1
systemctl start tigervncserver@:1