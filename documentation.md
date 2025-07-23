# Skaffold - Development Technologies

Skaffold is a development layer/tool that sits on top of Kubernetes,
Terraform or whatever framework we are using to write our manifest files.
The patterns used by this tool map to what is likely to be used in the
deployment of Vista in the cloud.

Skaffold will allow us to have a reproducible local development environment, and act similar to scripts running in `yarn` to start/stop/test/deploy containers, as well as allow for port-forwarding and handling pain points in local development.

Example Skaffhold for a simple load-balances (3 instances) http server:

```yaml
apiVersion: skaffold/v2beta26
kind: Config
metadata:
  name: nodejs-express-test
portForward:
  - resourceType: service
    resourceName: express-test-svc
    port: 8080
    localPort: 8080
build:
  local:
    useDockerCLI: true
  artifacts:
    - image: lukondefmwila/express-test
      docker:
        dockerfile: Dockerfile
test:
  - context: .
    image: lukondefmwila/express-test
    custom:
      - command: npm run test
deploy:
  kubectl:
    manifests:
      - manifests.yaml
```

Basic commands:

```bash
# run local instance with port-forwarding to local host
skaffold dev --port-forward --skip-tests
skaffold test # run specs inside container
skaffold deploy # deploy from manifest

# Boot up the express-test service, can be used to allow
# for booting into a service stand-alone, we can construct
# profiles to boot up the core of the system, and then use
# standalone services to boot with just the core (don't start
# 1000 services to test 1 or 2).
skaffhold dev --port-forward --profile=express-test

```

Skaffold also allows for profiles
