# Releasing and publishing sites

For maintainers. This is the single reference for both — the per-repository READMEs used to each carry their own version of it, and they had drifted into four mutually inconsistent recipes.

## One-time setup

Artifacts go to Maven Central through the Sonatype Central Portal. Add the token to your personal `~/.m2/settings.xml`:

```xml
<settings>
  <servers>
    <server>
      <id>sonatype-central-portal</id>
      <username><!-- Central Portal token username --></username>
      <password><!-- Central Portal token password --></password>
    </server>
  </servers>
</settings>
```

Generate the token pair at <https://central.sonatype.com/> under your account. It is a token, not your account password.

You also need a published GPG key — releases are signed.

## Releasing

Releases are cut with `maven-release-plugin` from the default branch:

```
mvn release:prepare
mvn release:perform
```

`release:prepare` tags and bumps versions; `release:perform` builds from the tag and deploys.

There is no manual publish step. `maven-release-plugin` is configured in the parent with `<goals>deploy</goals>` and `<releaseProfiles>plexus-release</releaseProfiles>`, so `release:perform` activates the `plexus-release` profile. That profile adds GPG signing, attaches sources and a source-release assembly, and sets `njord.enabled=true`.

[Njord](https://maveniverse.eu/docs/njord/) is registered as a build extension and configured with `autoPublish=true` and `publishingType=automatic`, so it publishes the deployment to Central itself. `njord.enabled` is `false` outside the release profile, so ordinary builds are unaffected.

Releasing needs Maven **3.9.0** or later — the `plexus-release` profile raises `minimalMavenBuildVersion` above the 3.6.3 required for a normal build.

Afterwards:

1. Check the [release drafter](https://github.com/codehaus-plexus/.github/blob/master/.github/workflows/release-drafter.yml) draft on the GitHub releases page, edit it into shape, and publish it once Central serves the POM. Release notes live on GitHub releases, not in the repository.
2. Publish the site, so the Javadoc and dependency reports on the site match what is now on Central. See below.

A release from a maintenance branch such as `plexus-utils-3.x` works the same way, with two differences. Release drafter keeps a separate draft for each branch, so edit that draft rather than creating a second one, and publish it with "Set as the latest release" cleared so the default branch's release stays the latest. Skip the site: each repository has one site, and publishing from a maintenance branch replaces the default branch's.

## Publishing the site

Sites are published to each repository's own `gh-pages` branch and served at `https://codehaus-plexus.github.io/<repository>/`. The parent POM sets `maven-site-plugin` to `skipDeploy`, so the publishing is done by `maven-scm-publish-plugin` against `scm.developerConnection`, not by `site:deploy`.

**Most repositories are single-module**, and bind `scm-publish:publish-scm` to the `site-deploy` phase. For those, the whole command is:

```
mvn -Preporting clean verify site-deploy
```

That covers plexus-utils, plexus-xml, plexus-io, plexus-archiver, plexus-interpolation, plexus-classworlds, plexus-testing, plexus-i18n, plexus-resources, plexus-velocity, plexus-build-api and plexus-sec-dispatcher.

**Multi-module repositories need staging first**, because the site has to be assembled across modules before it is pushed:

```
mvn -Preporting clean verify site site:stage scm-publish:publish-scm
```

That covers modello, plexus-compiler, plexus-languages and plexus-interactivity.

**plexus-pom is neither**, because it never grew the `scm-publish` execution the other single-module
projects have. `site-deploy` there publishes nothing at all, silently. Name the content directory instead:

```
mvn -Preporting clean verify site
mvn scm-publish:publish-scm -Dscmpublish.content=target/site
```

Without `scmpublish.content` the plugin looks in `target/staging`, which a single-module build never
creates.

### Before you publish

`scm-publish` makes `gh-pages` match the content directory exactly, so anything the build did not
produce is deleted from the live site. A site built the wrong way is still a green build; only the delete
count shows it. For every repository:

- **Build from a checkout of the release tag** (`target/checkout` after `release:perform`), so the site
  reports the version that is on Central rather than the next snapshot.
- **Use `-Preporting`.** It adds the Javadoc, surefire and project reports. Without it you publish a site
  with no API documentation and delete pages such as `project-reports.html`, which is worse than not
  republishing at all.
- **Build with the JDK that built the live Javadoc.** `apidocs/index.html` on the live site names it
  (`javadoc (25)`, for example). Javadoc from another JDK writes a different set of support files, and the
  ones it no longer writes are deleted.
- **Dry-run first** with `-Dscmpublish.dryRun=true`. It prints the additions, updates and deletes it would
  make. Expect zero deletes unless the release removed a report on purpose; a delete count anywhere near the
  size of the site means the content directory is wrong.

One deliberate exception: parent POM 28 dropped the JXR reports, so the first site published after a
repository moves to it deletes its `xref/` and `xref-test/` pages. Remove any `Source Xref` item from
`src/site/site.xml` in the same change as the parent bump.

Sites are published from a local checkout. There is no workflow for it: publishing puts content live with
no review step, and Maven site builds break often enough — doxia, site plugin and JDK interactions — that
the person doing it should see the output first.

## Snapshot deployment

The shared `maven-deploy.yml` workflow currently has snapshot publishing disabled (the step is a placeholder that echoes and exits). Don't rely on snapshots being on Central; build locally with `mvn install` instead.
