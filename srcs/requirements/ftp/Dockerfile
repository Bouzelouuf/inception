FROM debian:bullseye

# Mise à jour du système
RUN apt-get update && apt-get upgrade -y

# Installation du serveur FTP vsftpd
RUN apt-get install -y vsftpd

# Créer un utilisateur FTP
RUN useradd -m ftpuser && echo "ftpuser:ftppass42" | chpasswd

# Créer les dossiers nécessaires
RUN mkdir -p /var/run/vsftpd/empty && \
    mkdir -p /home/ftpuser/wordpress && \
    chown ftpuser:ftpuser /home/ftpuser/wordpress

# Configuration vsftpd
RUN echo "listen=YES" > /etc/vsftpd.conf && \
    echo "listen_ipv6=NO" >> /etc/vsftpd.conf && \
    echo "anonymous_enable=NO" >> /etc/vsftpd.conf && \
    echo "local_enable=YES" >> /etc/vsftpd.conf && \
    echo "write_enable=YES" >> /etc/vsftpd.conf && \
    echo "local_umask=022" >> /etc/vsftpd.conf && \
    echo "dirmessage_enable=YES" >> /etc/vsftpd.conf && \
    echo "use_localtime=YES" >> /etc/vsftpd.conf && \
    echo "xferlog_enable=YES" >> /etc/vsftpd.conf && \
    echo "connect_from_port_20=YES" >> /etc/vsftpd.conf && \
    echo "chroot_local_user=NO" >> /etc/vsftpd.conf && \
    echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf && \
    echo "secure_chroot_dir=/var/run/vsftpd/empty" >> /etc/vsftpd.conf && \
    echo "pam_service_name=vsftpd" >> /etc/vsftpd.conf && \
    echo "pasv_enable=YES" >> /etc/vsftpd.conf && \
    echo "pasv_min_port=21100" >> /etc/vsftpd.conf && \
    echo "pasv_max_port=21110" >> /etc/vsftpd.conf && \
    echo "pasv_promiscuous=YES" >> /etc/vsftpd.conf

# Port FTP
EXPOSE 21 21100-21110

# Lancer vsftpd
CMD ["vsftpd", "/etc/vsftpd.conf"]