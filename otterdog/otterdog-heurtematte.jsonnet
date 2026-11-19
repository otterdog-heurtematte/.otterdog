local orgs = import "vendor/otterdog-defaults/resources/otterdog-defaults.libsonnet";

orgs.newOrg("otterdog-heurtematte", "otterdog-heurtematte") {
  code_security_configurations+: [
    orgs.newOrgCodeSecurityConfiguration('baseline') {
      description: "Secret scanning and Dependabot for all repositories",
    },
  ],
  settings+: {
    members_can_change_project_visibility: false,
    packages_containers_internal: false,
    packages_containers_public: false,
    web_commit_signoff_required: false,
    custom_properties+: [
      orgs.newCustomProperty("test") {
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
    orgs.newTeam("test-team") {
      members+: [
        "heurtematte",
        "sebastienheurtematte",
      ],
    },
  ],
  secrets+: [
    orgs.newOrgSecret("OTTER_API_TOKEN") {
      value: "********",
    },
    orgs.newOrgSecret("OTTER_PASSWORD") {
      value: "********",
    },
    orgs.newOrgSecret("OTTER_TOTP_SEED") {
      value: "********",
    },
    orgs.newOrgSecret("OTTER_USERNAME") {
      value: "********",
    },
  ],
  actions_policies+: [
    orgs.newOrgActionsPolicy('release') {
      include_repo_names: ["~ALL"],
      include_workflows: [".github/workflows/release.yml"],
      allowed_actors: ["#Maintain", "@otterdog-heurtematte/test-team"],
      allowed_events: ["workflow_dispatch"],
    },
  ],
  _repositories+:: [
    orgs.newRepo(".otterdog") {
      allow_forking: false,
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      has_wiki: false,
      private: true,
      web_commit_signoff_required: false,
    },
    orgs.newRepo("helm-charts") {
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
    orgs.newRepo("otterdog") {
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
        orgs.newRepoSecret("GH_PREVIEW_TOKEN") {
          value: "********",
        },
      ],
      environments: [
        orgs.newEnvironment("pull-request-preview") {
        },
      ],
    },
    orgs.newRepo("otterdog-configs") {
      description: "otterdog configs 2",
      allow_forking: false,
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      has_wiki: false,
      private: true,
      web_commit_signoff_required: false,
    },
    orgs.newRepo("otterdog-defaults") {
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
    orgs.newRepo("test-repo") {
      code_security_configuration: "baseline",
      description: "OtterDog test repository from PR test3 change2",
      workflows+: {
        sha_pinning_required: true,
      },
      actions_policies: [
        orgs.newRepoActionsPolicy('release') {
          include_workflows: [".github/workflows/release.yml"],
          allowed_actors: ["#Maintain"],
          name: "test",          
        },
      ],
      rulesets: [
        orgs.newRepoRuleset('restrict-files') {
          target: "push",
          allows_creations: true,
          allows_deletions: true,
          allows_force_pushes: true,
          required_pull_request: null,
          required_status_checks: null,
        },
        orgs.newRepoRuleset("main") {
          include_refs+: [
            "refs/heads/main/**/*",
          ],
          required_pull_request+: {
            required_approving_review_count: 1,
            requires_review_thread_resolution: true,
            allowed_merge_methods: ["squash","rebase"],
          },
          bypass_actors+: [
            "@otterdog-heurtematte/otterdog-heurtematte-project-leads"
          ],
          allows_creations: true,
          copilot_code_review: orgs.newCopilotCodeReview() {
            review_on_push: true,
          },
          requires_linear_history: true,
          commit_message_pattern: orgs.newPattern() {
            name: "Conventional Commits",
            operator: "regex",
            pattern: "^(feat|fix|docs|chore|refactor|test|ci|build|perf|revert)(\\(.+\\))?!?: ",
          },
          branch_name_pattern: orgs.newPattern() {
            name: "Branch prefix",
            operator: "regex",
            pattern: "^(feature|fix|release|dependabot)/",
          },
          required_code_scanning: orgs.newCodeScanning() {
            code_scanning_tools+: [
              "CodeQL:high_or_higher:errors",
            ],
          },
          requires_license_compliance_scanning: true,
          required_code_quality: orgs.newCodeQuality() {
            severity: "warnings",
          },
          required_code_coverage: orgs.newCodeCoverage() {
            minimum_coverage: 80,
            max_coverage_drop: 1,
          },
        },        
      ],
    },
    orgs.newRepo("otterdog-import-repo") {
      description: "test import existing repo sync with otterdog",
    },
    orgs.newRepo("otterdog-repo-private") {
      description: "test private repo",
      private: true,
      allow_forking: false,      
    },
    orgs.newRepo("otterdog-repo-private2") {
      description: "test private repo",
      private: true,
      allow_forking: false,      
    },
    orgs.newRepo("otterdog-repo-private3") {
      description: "test private repo",
      private: true,
      allow_forking: false,      
    },
    orgs.newRepo("test-repo-auto-merge") {
      description: "OtterDog test repository for auto-merge check merge",
    },
    orgs.newRepo("test-repo-code-scannning") {
      description: "OtterDog test repository for code-scanning",
      code_scanning_default_setup_enabled: false,
      code_scanning_default_languages+: [
        "java-kotlin",
      ],
    },
  ],
}
