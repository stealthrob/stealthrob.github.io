# GitHub Pages Duplicate Deployment Investigation

**Date:** January 9, 2026
**Issue:** Two "pages build and deployment" workflows running simultaneously
**Repository:** stealthrob/stealthrob.github.io

## Problem Statement

Multiple GitHub Pages deployment workflows are triggered concurrently for the same push/merge event, causing:
- Duplicate builds running in parallel
- Wasted GitHub Actions minutes
- Potential race conditions in deployment
- Confusion about which deployment is active

## Investigation Findings

### 1. Repository Structure Analysis

**Jekyll Site Configuration:**
- Site Type: Jekyll static site (minima theme)
- Primary Branch: master
- Pages Domain: Custom CNAME configured
- No custom GitHub Actions workflows (`.github/workflows/` does not exist)

**Current Branch State:**
```
Current Branch: claude/investigate-duplicate-deployments-uLLD6
Main Branch: master
Status: Clean working directory
```

### 2. Recent Activity Timeline

**Recent Commits:**
```
e288a3a (Jan 9, 2026 16:00:03 EST) - Merge pull request #2
  ├─ a25b703 - Update dependencies to address security vulnerabilities
  └─ 98200418 - Fix critical UI issues
d11674e (Dec 4, 2024 07:34:41 EST) - Update CNAME
0bc8124 (Dec 4, 2024 07:28:50 EST) - Create CNAME
```

**Correlation:**
- PR #2 merged at 16:00:03 EST
- Duplicate deployments observed immediately after merge
- Four total workflow runs visible, with two running concurrently

### 3. Workflow Analysis

**Observed Workflows:**
1. **bundler in /. for bundler - Update #1205218460**
   - Status: In Progress
   - Trigger: Dependabot Updates #1
   - Branch: master

2. **pages build and deployment #6**
   - Status: In Progress
   - Trigger: Manual/Push by stealthrob
   - Branch: master

3. **pages build and deployment #5**
   - Status: Completed (35s)
   - Timestamp: Dec 4, 2024, 7:34 AM EST
   - Branch: master

4. **pages build and deployment #4**
   - Status: Completed (39s)
   - Timestamp: Dec 4, 2024, 7:28 AM EST
   - Branch: master

### 4. Root Cause Analysis

**Primary Hypothesis: Dual Deployment Source Configuration**

GitHub Pages supports two deployment methods:
1. **Legacy: Deploy from a branch** (automatic Jekyll build)
2. **Modern: GitHub Actions** (explicit workflow)

When both are enabled simultaneously, each push triggers BOTH deployment pipelines, resulting in duplicate builds.

**Evidence Supporting This Hypothesis:**
- No custom workflow file exists, yet "pages build and deployment" workflows run
- Workflows appear as GitHub-generated (not user-defined)
- Timing suggests parallel triggers from the same event
- Both workflows target the same branch (master)

**Secondary Contributing Factors:**

1. **Merge Commit Event Propagation**
   - Merge commits generate multiple webhook events
   - GitHub may process branch update + PR merge as separate triggers

2. **Dependabot Concurrent Activity**
   - Dependabot workflow running simultaneously
   - May interact with deployment triggers

3. **No Concurrency Controls**
   - Absence of `concurrency` group configuration
   - No automatic cancellation of redundant builds

## Recommended Solutions

### Solution 1: Configure Single Deployment Source (Recommended)

**Steps:**
1. Navigate to: Repository Settings → Pages
2. Under "Build and deployment" section
3. Verify "Source" dropdown setting
4. Ensure ONLY ONE option is selected:
   - **Recommended:** "GitHub Actions" (modern, more control)
   - **Alternative:** "Deploy from a branch" (simpler, less flexible)

**If "GitHub Actions" is selected:**
- Disable any "Deploy from a branch" configuration
- Ensure no legacy deployment webhook is active

**If "Deploy from a branch" is selected:**
- Remove/disable GitHub Actions deployment source
- Verify no `.github/workflows/pages.yml` will be created

### Solution 2: Add Concurrency Control (If Using Custom Workflows)

If you decide to create a custom deployment workflow, add concurrency control:

```yaml
name: Deploy Jekyll site to Pages

on:
  push:
    branches: ["master"]
  workflow_dispatch:

# Prevent concurrent deployments
concurrency:
  group: pages-deployment
  cancel-in-progress: true

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      # ... build steps ...

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      # ... deployment steps ...
```

### Solution 3: Branch Protection Rules (Long-term)

Configure branch protection on master:
1. Settings → Branches → Branch protection rules
2. Require status checks before merging
3. Include Pages deployment as required check
4. This prevents incomplete deployments from becoming active

## Verification Steps

After implementing Solution 1:

1. **Make a test commit to master**
   ```bash
   git checkout master
   git commit --allow-empty -m "Test: Verify single deployment"
   git push origin master
   ```

2. **Monitor Actions tab**
   - Navigate to: Actions → All workflows
   - Verify only ONE "pages build and deployment" workflow starts
   - Confirm no duplicate workflows appear

3. **Check deployment status**
   - Visit: Settings → Pages
   - Confirm deployment source shows correctly
   - Verify site URL is accessible

## Additional Observations

### Gemfile Configuration
The repository uses GitHub Pages gem for dependency management:
```ruby
gem "github-pages", group: :jekyll_plugins
```

This is compatible with both deployment methods but may influence build behavior.

### CNAME History
Multiple CNAME changes observed in commit history:
- Created and deleted several times (2023-2024)
- Currently configured
- Frequent CNAME changes can trigger redeployments

## Impact Assessment

**Current Impact:**
- ❌ Duplicate workflow runs (wasted compute resources)
- ❌ Potential for race conditions
- ❌ Unclear which deployment is "active"
- ✅ Site functionality not affected (deployments still complete)

**Post-Fix Impact:**
- ✅ Single deployment per trigger
- ✅ Clearer workflow status
- ✅ Reduced Actions minutes usage
- ✅ Faster feedback on deployment status

## Conclusion

The duplicate deployments are most likely caused by having both "Deploy from a branch" and "GitHub Actions" enabled as deployment sources in the repository's Pages settings. This configuration causes every push to master to trigger two separate deployment pipelines.

**Immediate Action Required:**
Review and correct the Pages deployment source configuration in repository settings.

**Expected Outcome:**
Only one deployment workflow per push/merge event.

---

*Report Generated: January 9, 2026*
*Investigator: Claude (AI Assistant)*
*Branch: claude/investigate-duplicate-deployments-uLLD6*
