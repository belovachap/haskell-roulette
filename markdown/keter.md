# Overview

`keter` is an application server. You create a bundle (a gzip'ed tar file ending in the extension `.keter`) from your Yesod Stack project by running the command `yesod keter`. To deploy the bundle, copy it `/opt/keter/incoming` on your server.

# Installation

A recent version of `keter` had an [issue](https://github.com/snoyberg/keter/issues/291) where it would error out with a message along the lines of `FileNotExecutable`. To work around this I built `keter` from the most recent [GitHub source code](https://github.com/snoyberg/keter). Clone it to your computer then build/install it locally with `stack install`. Then copy the executable to your server at `/opt/keter/bin` and create a Systemd service for it:

```
# /etc/systemd/system/keter.service
[Unit]
Description=Keter
After=network.service

[Service]
Type=simple
ExecStart=/opt/keter/bin/keter /opt/keter/etc/keter-config.yaml

[Install]
WantedBy=multi-user.target
```

# Snippets
