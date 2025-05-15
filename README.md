# SaunaFS container

### Base container

Build base container:

```
$ cd saunafs-base
$ podman build . -t saunafs-chunkserver:latest
```

### Master

Build master container:

```
$ cd saunafs-master
$ podman build . -t saunafs-master:latest
```

Run master:

```
$ podman run  --net host -it --rm saunafs-master:latest -d
```

To do:
- [ ] Provision volume (persistence)
- [ ] Provide a configuration file from host (environment vars could be a nice and elegant solution)
- [ ] Verify that `--net host` is the way to go (performace wise) but should be okay
- [ ] **Implement a check to preserve existent metadata** ! 
### Chunkserver

Build chunkserver container:

```
$ cd saunafs-chunkserver
$ podman build . -t saunafs-chunkserver:latest
```

To do:
- [x] Fixed configuration example syntax error in 
- [ ] Provide a smart way to populate sfshdd.cfg
- [ ] Mount /mnt OR /mnt/hdd 
- [ ] Remove the argument MASTER_HOST and move to a configuration file OR env vars
- [ ] Provide a configuration file from host 

Run chunkserver:

```
$ podman run --net host -it --rm saunafs-chunkserver:latest 127.0.0.1 #loopback is experimental, just dev purpose
```
