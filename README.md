
## [Webogram Docker Proxy](https://web.telegram.org) 

****Telegram web proxy server****

This fork of webogram contains docker image with redsocks and nginx proxy to use in case of blocked of web.telegram.org

Regards to
* https://github.com/zhukov/webogram
* https://gist.github.com/stek29/47a4a02c4fb82d79dbe52d4f36efe163
* https://github.com/zhukov/webogram/issues/1863

### Running in docker

1. Replace lines in files [nginx/nginx.conf](nginx/nginx.conf) with your domain name
    ```
   yourdomain.com
    ```
   
2. Replace line in file [app/js/lib/mtproto.js](app/js/lib/mtproto.js) with your domain name
   ```
   chosenServer = 'https://yourdomain.com/' + subdomain + path
   ```
3. Generate ssl for your domain name and replace files in  [nginx/certs](nginx/certs).

4. Optionally, generate new login/password in [nginx/.htpasswd](nginx/.htpasswd) for baisc http auth (default creds test/telegram).

5. Update [redsocks/redsocks.conf](redsocks/redsocks.conf) with your socks proxy credentials. I recommend [proxy6](https://proxy6.net/?r=135337). If *.telegram.org isn't banned from your server  - skip this step and remove/comment lines from [redsocks/redsocks](redsocks/redsocks) 
    ```
    iptables_rules
    /usr/sbin/redsocks -c /tmp/redsocks.conf
    ```
6. Run cmd in webogram dir
    ```
    docker build -t tgnginx . && docker run -p 80:80 -p 443:443 --name tgnginx --cap-add NET_ADMIN --cap-add NET_RAW tgnginx
    ```
7. Open https://yourdomain.com/ in your browser and enjoy.


