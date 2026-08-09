// Canonical label set for the codehaus-plexus organisation.
//
// This is deliberately the same format, and very nearly the same content, as
// apache/maven-gh-actions-shared/.github/labels.js. Most plexus components are
// consumed by Maven and many contributors move between the two orgs, so a
// contributor should not have to learn two vocabularies.
//
// Where the two sets differ, the difference is intentional and noted below.
// Applied by .github/workflows/label-sync.yml.
//
// Colour rule: no two labels share a colour, and any two that can appear side
// by side differ in text colour too — GitHub picks white or black from
// brightness, so a same-hue ramp is unreadable at label-pill size.

module.exports = [
    // ---- Impact --------------------------------------------------------
    {
        name: "breaking",
        color: "B60205",
        description: "Pull requests that break existing features"
    },
    {
        name: "removed",
        color: "BC7855",
        description: "Pull requests that remove features"
    },
    {
        name: "deprecated",
        color: "C70132",
        description: "Pull requests that deprecate features"
    },
    {
        name: "bug",
        color: "d73a4a",
        description: "Something isn't working"
    },

    // ---- Kind of change ------------------------------------------------
    {
        name: "enhancement",
        color: "a2eeef",
        description: "New feature or request"
    },
    {
        name: "documentation",
        color: "0075ca",
        description: "Improvements or additions to documentation"
    },
    {
        name: "maintenance",
        color: "912E29",
        description: "Cleanup, refactoring or other internal change"
    },
    {
        name: "build",
        color: "795548",
        description: "Pull requests that change the build process"
    },

    // ---- Applied by Dependabot -----------------------------------------
    {
        name: "dependencies",
        color: "0366d6",
        description: "Pull requests that update a dependency file"
    },
    {
        name: "java",
        color: "ffa221",
        description: "Pull requests that update Java code"
    },
    {
        // Not in the Maven set: Dependabot creates it anyway, so declaring it
        // is the only way it gets a description and a settled colour.
        name: "github_actions",
        color: "79B8FF",
        description: "Pull requests that update GitHub Actions code"
    },

    // ---- Severity ------------------------------------------------------
    {
        name: "priority:blocker",
        color: "cc0000",
        description: "Blocks development and/or testing work, production could not run"
    },
    {
        name: "priority:critical",
        color: "ff0000",
        description: "Crashes, loss of data, severe memory leak"
    },
    {
        name: "priority:major",
        color: "009900",
        description: "Major loss of function"
    },
    {
        name: "priority:minor",
        color: "006600",
        description: "Minor loss of function, or other problem where easy workaround is present"
    },
    {
        name: "priority:trivial",
        color: "003300",
        description: "Cosmetic problem like misspelled words or misaligned text"
    },

    // ---- Needs a human -------------------------------------------------
    {
        name: "help wanted",
        color: "008672",
        description: "Extra attention is needed"
    },
    {
        name: "good first issue",
        color: "7057ff",
        description: "Good for newcomers"
    },
    {
        name: "question",
        color: "d876e3",
        description: "Further information is requested"
    },
    {
        // Not in the Maven set. Superset applies the equivalent automatically
        // via eps1lon/actions-label-merge-conflict; worth doing here too.
        name: "need-rebase",
        color: "D4C5F9",
        description: "Branch has conflicts and needs a rebase before it can merge"
    },
    {
        name: "waiting-for-feedback",
        color: "ffffff",
        description: "Waiting for 90 days until issues or pull request will be closed"
    },

    // ---- Triage --------------------------------------------------------
    {
        name: "duplicate",
        color: "cfd3d7",
        description: "This issue or pull request already exists"
    },
    {
        name: "invalid",
        color: "e4e669",
        description: "This doesn't seem right"
    },
    {
        name: "wontfix",
        color: "6E7781",
        description: "This will not be worked on"
    },

    // ---- Excluded from the release notes -------------------------------
    {
        name: "skip-changelog",
        color: "2F6F6F",
        description: "Skip this PR from automatically changelog generation"
    },
    {
        // Not in the Maven set, but the Maven release-drafter config already
        // excludes it, so the label and the config agree across both orgs.
        name: "reverted",
        color: "24292F",
        description: "Change was reverted; excluded from the release notes"
    }
]
