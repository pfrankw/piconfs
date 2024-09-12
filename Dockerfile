# Use the official Alpine image as a base
FROM alpine:3

# Install NFS utilities
RUN apk update && \
    apk add nfs-utils

#RUN mkdir -p /var/lib/nfs/v4recovery
# Create the directory to share
RUN mkdir -p /export

# Add configuration files
RUN echo "/export *(rw,sync,fsid=0,no_root_squash,no_subtree_check)" > /etc/exports

# Expose the necessary ports
EXPOSE 2049/tcp

# Start the NFS server and keep the container running
CMD ["/bin/sh", "-c", "exportfs -r && rpc.nfsd --debug 8 --no-nfs-version 3 && nfsdcld --debug && rpc.mountd --no-nfs-version 3 --foreground"]
