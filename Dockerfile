FROM centos:7
WORKDIR /root
RUN mkdir -p /etc/nginx/conf.d /etc/nginx/ssl && mkdir -p /usr/local/nginx-ntlm-module && yum install nano git wget epel-release zip unzip -y
COPY Files/compile.sh /root/
COPY Files/ngx_http_upstream_ntlm_module.c /usr/local/nginx-ntlm-module
COPY Files/config /usr/local/nginx-ntlm-module
RUN cd /root && chmod +x compile.sh  && ./compile.sh
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
COPY nginx.conf /usr/local/nginx/conf/nginx.conf
EXPOSE 80:80 443:443
RUN /usr/local/nginx/sbin/nginx 
ENTRYPOINT ["/docker-entrypoint.sh"]