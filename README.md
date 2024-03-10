# UDS In My Nucs and Crannies

Bundles and scripts we are using to deploy UDS things into our nucs-n-crannies

TLDR;
While connected:
- Install and deploy RKE2. See [this readme](rke2/README.md)
- Build all the bundles
- Deploy init-bundle (Needs internet)

Shudown machine...
Disconnect from network...
Startup machine...

Disconnected
- Update and run `dummy-nic.sh` This will set up dummy route with the original IP and restart RKE2
- RKE2 cluster should be back :fingers-crossed:
- Deploy uds-core, ai4ns, swf bundles. This can also happen while connected if you wish
- Connect to machine via thunderbolt network connection
- ssh into machine through that connection and show all the things

## UDS Tasks to build and deploy
Once connected to the cluster you can run UDS tasks to build and deploy the bundle.

```bash
# Create init bundle
uds run create-init-bundle

# Create uds-core bundle
uds run create-uds-core-bundle

# Create ai4ns bundle
uds run create-ai4ns-bundle

# Create swf bundle
uds run create-swf-bundle

# Deploy init bundle
uds run deploy-init-bundle

# Deploy uds-core bundle (10m)
uds run deploy-uds-core-bundle

# Deploy ai4ns bundle (4m)
uds run deploy-ai4ns-bundle

# Deploy swf bundle (? Probably 5m) Hit disc pressure issue before I could finish
uds run deploy-swf-bundle
```