# Security Policy

This policy covers every repository in the [codehaus-plexus](https://github.com/codehaus-plexus) organisation.

## Reporting a vulnerability

**Please do not open a public issue or pull request for a security problem.**

Report it privately through GitHub, using the **Report a vulnerability** button on the Security tab of the affected repository. That opens a private advisory visible only to the maintainers:

> `https://github.com/codehaus-plexus/<repository>/security/advisories/new`

If you aren't sure which repository is affected, report against the one you believe is closest and say so in the report; we will move it.

A report is most useful when it includes the affected artifact and version, how the issue can be triggered, and what an attacker gains. A reproducer is worth a great deal.

## What happens next

We will confirm the report, work on a fix privately, and publish a GitHub Security Advisory with a CVE when the fix is released. Where a fix isn't possible or the report turns out not to be a vulnerability, we will tell you that and why.

Plexus is maintained by volunteers, so we cannot promise a response time. If a report goes unacknowledged for a couple of weeks, please feel free to nudge us in the advisory thread.

We are glad to credit reporters in the advisory. Tell us how you would like to be named, or that you would rather not be.

## Which versions get fixes

Fixes go onto the current development line of the affected project, and are released from there. Whether a fix is also backported to an older line is decided case by case, based on how widely that line is still used — we do not maintain a fixed list of supported versions.

## Scope

This policy covers the code in this organisation's repositories and the artifacts published from them to Maven Central under `org.codehaus.plexus` and `org.codehaus.modello`.

Archived repositories — listed on the [organisation profile](https://github.com/codehaus-plexus) — receive no fixes of any kind, including security fixes. If you find a vulnerability in one, we would still like to know, so we can point people away from it, but the answer will be to migrate rather than to patch.
