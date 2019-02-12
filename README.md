# susemanager-cloud-setup

This is a simple script to set up a storage device for use with SUSE Manager.
There are two versions, the server and the proxy version. Both versions
partition and fromat the given block device and mount it to the system, The
server version is for SUSE Manager Server and moves the package repository and
the data base to the given device. The proxy version is for SUSE Manager Proxy
and moves the squid cache to the given device.

## Installation
```
make install
```

## Usage

```
suma-storage-[server|proxy] block_device
```

### Notes

`susemanager-cloud-setup` does not add the storage device to `/etc/fstab`.
