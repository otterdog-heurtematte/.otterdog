local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('otterdog-heurtematte', 'otterdog-heurtematte') {
  settings+: {
    members_can_change_project_visibility: false,
    packages_containers_internal: false,
    packages_containers_public: false,
    web_commit_signoff_required: false,
    custom_properties+: [
      orgs.newCustomProperty('test') {
        default_value: "otterdog-heurtematte",
        description: "The Eclipse project test property.",
        required: true,
      },
    ],
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  teams+: [
    orgs.newTeam('otterdog-heurtematte-project-leads') {
      members+: [
        "heurtematte"
      ],
    },
    orgs.newTeam('test-team') {
      members+: [
        "heurtematte",
        "sebastienheurtematte"
      ],
    },
  ],
  secrets+: [
    orgs.newOrgSecret('OTTER_API_TOKEN') {
      value: "********",
    },
    orgs.newOrgSecret('OTTER_PASSWORD') {
      value: "********",
    },
    orgs.newOrgSecret('OTTER_TOTP_SEED') {
      value: "********",
    },
    orgs.newOrgSecret('OTTER_USERNAME') {
      value: "********",
    },
  ],
  _repositories+:: [
    orgs.newRepo('.otterdog') {
      allow_forking: false,
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      has_wiki: false,
      private: true,
      web_commit_signoff_required: false,
    },
    orgs.newRepo('helm-charts') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      description: "This repository contains the helm-charts source from Eclipse Foundation Security Infrastructure projects.",
      has_issues: false,
      homepage: "https://eclipse-csi.github.io/helm-charts/",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
    },
    orgs.newRepo('otterdog') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      description: "OtterDog is a tool to manage GitHub organizations at scale using a configuration as code approach. It is actively used by the Eclipse Foundation to manage its numerous projects hosted on GitHub.",
      has_issues: false,
      homepage: "https://otterdog.readthedocs.org",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      secrets: [
        orgs.newRepoSecret('GH_PREVIEW_TOKEN') {
          value: "********",
        },
      ],
      environments: [
        orgs.newEnvironment('pull-request-preview') {
        },
      ],
    },
    orgs.newRepo('otterdog-configs') {
      description: "otterdog configs",
      allow_forking: false,
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      has_wiki: false,
      private: true,
      web_commit_signoff_required: false,
    },
    orgs.newRepo('otterdog-defaults') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      description: "Hosts the default configuration used by the Eclipse Foundation to manage the GitHub organizations of projects hosted on GitHub.",
      has_issues: false,
      has_wiki: false,
      homepage: "",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      web_commit_signoff_required: false,
    },
    orgs.newRepo('test-repo') {
      description: "OtterDog test repository from PR",
    },
  ],
}
