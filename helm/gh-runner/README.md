# gh-runner Helm Chart

A Helm chart for deploying a self-hosted GitHub Actions runner.

## Features

- Deploys a GitHub Actions runner to Kubernetes
- Supports custom runner labels, group, and work directory
- Securely injects GitHub runner token via Kubernetes Secret
- Optional Docker registry image pull secret

## Prerequisites

- Kubernetes cluster
- Helm 3.x
- GitHub token that allows runners creation

## Installation

1. **Prepare your values:**
   Edit [`values.yaml`](helm/gh-runner/values.yaml) and set:
   - `gh_runner_token.value`: Base64-encoded GitHub Runner token
   - `containers.github_repository`: Your GitHub repository URL
   - Optionally adjust image, labels, resources, etc.

2. **Install the chart:**
   ```sh
   helm install helm-gh-runner <path_to_chart>
   ```

## Configuration

See [`values.yaml`] for all available options.

| Parameter                           | Description                                 | Default                        |
|-------------------------------------|---------------------------------------------|--------------------------------|
| `namespace`                         | Namespace to deploy runner                  | `gh-runner`               |
| `containers.image`                  | Runner container image                      | `adriant7/gh-runner`           |
| `containers.github_repository`      | GitHub repository URL                       | *(set your repo)*              |
| `gh_runner_token.value`             | Base64 GitHub Runner token                  | `""`                           |
| `imagePullSecrets.enabled`          | Enable Docker registry secret               | `false`                        |
| `imagePullSecrets.dockerconfigjson` | Base64 dockerconfigjson                     | `""`                           |

**Mandatory variables**
- `containers.github_repository`
- `gh_runner_token.value`

If you won't set these values, your deployment will fail.

**Namespace**
If you set namespace in `values.yaml`, it must match the namespace you pass with `--namespace` during install.

## Example

```yaml
gh_runner_token:
  name: gh-runner-token
  value: "<base64-github-token>"

containers:
  github_repository: "https://github.com/user/repository"
```

## Uninstall

```sh
helm uninstall gh-runner
```

## Related Projects

- **gh-runner** ([GitHub](https://github.com/AdrianT7/gh-runner))  
  This repo builds GitHub Actions self-hosted runner images using **Kaniko**.  
  Docker images of my runners are available on [Docker Hub](https://hub.docker.com/repository/docker/adriant7/gh-runner/) for use in your own infrastructure.

## License

MIT