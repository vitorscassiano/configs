---
name: monitoring-argocd-apps
description: Monitors ArgoCD applications on PicPay clusters. Use when asked to check application deployment status, sync status, health, view logs, or troubleshoot failing pods. Keywords - argocd, argo, gitops, deployment, sync, kubernetes, k8s, application, moonlight.
---

# Monitoring ArgoCD Applications

## Cluster Configuration

| Environment | ArgoCD Server | Description |
|-------------|---------------|-------------|
| Staging | `cd.moonlight.qa.ppay.me` | QA/Homologation deployments |
| Production | `cd.moonlight.ppay.me` | Production deployments |

## Authentication

ArgoCD authentication uses environment variables:
- `ARGOCD_USERNAME` - ArgoCD username
- `ARGOCD_PASSWORD` - ArgoCD password

**Important**: Always use `--grpc-web` flag for all ArgoCD CLI commands.

### Login Commands

```bash
# Login to Staging
argocd login cd.moonlight.qa.ppay.me --username "$ARGOCD_USERNAME" --password "$ARGOCD_PASSWORD" --grpc-web

# Login to Production
argocd login cd.moonlight.ppay.me --username "$ARGOCD_USERNAME" --password "$ARGOCD_PASSWORD" --grpc-web
```

## Common Operations

### List Applications

```bash
# List all applications
argocd app list --grpc-web

# Filter by name (case-insensitive)
argocd app list --grpc-web | grep -i <app-name>

# Example: Find NATS apps
argocd app list --grpc-web | grep -i nats
```

### Get Application Status

```bash
# Get detailed application status
argocd app get <app-name> --grpc-web

# Example output includes:
# - Project, Server, Namespace
# - Source repo, path, values files
# - Sync Status (Synced/OutOfSync)
# - Health Status (Healthy/Progressing/Degraded)
# - Resource list with individual status
```

### View Application Logs

```bash
# Get logs for all pods in an application
argocd app logs <app-name> --grpc-web

# Get logs for specific resource kind
argocd app logs <app-name> --kind StatefulSet --grpc-web
argocd app logs <app-name> --kind Deployment --grpc-web
```

### Sync Application

```bash
# Manual sync
argocd app sync <app-name> --grpc-web

# Sync with prune (remove resources not in git)
argocd app sync <app-name> --prune --grpc-web
```

## Status Interpretation

### Sync Status

| Status | Meaning |
|--------|---------|
| `Synced` | Application state matches git repository |
| `OutOfSync` | Application state differs from git repository |
| `Unknown` | Unable to determine sync status |

### Health Status

| Status | Meaning |
|--------|---------|
| `Healthy` | All resources are healthy and running |
| `Progressing` | Resources are being created/updated (pods starting) |
| `Degraded` | One or more resources are unhealthy |
| `Suspended` | Application is suspended |
| `Missing` | Resources are missing from the cluster |
| `Unknown` | Unable to determine health status |

### Resource Status

| Status | Meaning |
|--------|---------|
| `Synced` | Resource matches desired state |
| `OutOfSync` | Resource differs from desired state |
| `Running` | Resource is being applied |

## Troubleshooting

### CrashLoopBackOff Pods

When pods are in CrashLoopBackOff:

1. **Check application status**:
   ```bash
   argocd app get <app-name> --grpc-web
   ```

2. **View pod logs**:
   ```bash
   argocd app logs <app-name> --grpc-web
   ```

3. **Common causes**:
   - Configuration errors (check ConfigMaps)
   - Invalid values in Helm charts (type mismatches)
   - Missing secrets or environment variables
   - Resource limits too low
   - Image pull failures

### Example: Config Type Error

Error: `interface conversion: interface {} is string, not int64`

This means a NATS/application config expects an integer but received a string.
- Wrong: `max_payload: 8MB`
- Correct: `max_payload: 8388608` (8MB in bytes)

## Monitoring Workflow

When asked to monitor a deployment:

1. **Login to the appropriate ArgoCD**:
   ```bash
   # For staging
   argocd login cd.moonlight.qa.ppay.me --username "$ARGOCD_USERNAME" --password "$ARGOCD_PASSWORD" --grpc-web

   # For production
   argocd login cd.moonlight.ppay.me --username "$ARGOCD_USERNAME" --password "$ARGOCD_PASSWORD" --grpc-web
   ```

2. **Find the application**:
   ```bash
   argocd app list --grpc-web | grep -i <app-name>
   ```

3. **Check status**:
   ```bash
   argocd app get <app-name> --grpc-web
   ```

4. **If Progressing**, wait for pods to start (normal during deployment)

5. **If Degraded**, check logs:
   ```bash
   argocd app logs <app-name> --grpc-web
   ```

## Application Naming Convention

Applications typically follow the pattern:
- `<app-name>-hom` for staging/homologation
- `<app-name>-prd` for production

Example:
- `ops-nats-hom` (staging NATS deployment)
- `ops-nats-prd` (production NATS deployment)
