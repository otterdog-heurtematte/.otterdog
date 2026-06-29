local orgs = import 'vendor/otterdog/examples/template/otterdog-defaults.libsonnet';

orgs.newOrg('otterdog-heurtematte', 'otterdog-heurtematte') {
  settings+: {
    billing_email: "sebastien.heurtematte@eclipse-foundation.org",
    members_can_change_project_visibility: false,
     packages_containers_internal: false,
    packages_containers_public: false,
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
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
    },
    orgs.newRepo('otterdog-configs') {
      allow_forking: false,
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      has_wiki: false,
      private: true,
      web_commit_signoff_required: false,
    },
    orgs.newRepo('test-repo') {
      description: "OtterDog test repository",
    },
  ],
}
