# xsim scripts 
Prepare, submit, pull, and plot a series of calculations that scans a
paramerter in the KDC model. Support for xsim (part of CFOUR) and xsimplot.py.


For plotting, place an `xsimplot.toml` config file in the scan subdirectory.


## User and domain trick in push/pull scripts
Here is how to avoid typing 
```bash
ssh user@host.domain
```

1. Set an alias in `/etc/hosts`, i.e., a line like this
```
127.0.0.1 hpc
```
You can find your server's ip with 
```bash
nslookup <host.domain>
```

2. In `~/.ssh/config` set the default user for your cluster
```
Host hpc
  User <user>
```

With these two changes you can now simply
```bash
ssh hpc
```
The same goes for `rsync`.
