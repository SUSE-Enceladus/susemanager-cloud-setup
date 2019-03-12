# susemanager-cloud-setup

This project contains a few scripts to help set up SUSE Manager in the public
cloud. It is not a replacement for the YaST2 `susemanager_setup` module,
but it contains a hook script for it that creates a user account for the
administrator automatically.

This repository also contains scripts to set up a storage device for use with
SUSE Manager. There are two versions, the server and the proxy version. Both
versions partition and fromat the given block device and mount it to the
system, The server version is for SUSE Manager Server and moves the package
repository and the data base to the given device. The proxy version is for SUSE
Manager Proxy and moves the squid cache to the given device.

## Installation
```
make install
```

## Usage

```
suma-storage-[server|proxy] block_device
```

The hook script for YaST2 is executed automatically.
