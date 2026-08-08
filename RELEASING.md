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

1. Check the [release drafter](https://github.com/codehaus-plexus/.github/blob/master/.github/workflows/release-drafter.yml) draft on the GitHub releases page, edit it into shape, and publish it. Release notes live on GitHub releases, not in the repository.
2. Publish the site, so the Javadoc and dependency reports on the site match what is now on Central. See below.

## Publishing the site

Sites are published to each repository's own `gh-pages` branch and served at `https://codehaus-plexus.github.io/<repository>/`. The parent POM sets `maven-site-plugin` to `skipDeploy`, so the publishing is done by `maven-scm-publish-plugin` against `scm.developerConnection`, not by `site:deploy`.

**Most repositories are single-module**, and bind `scm-publish:publish-scm` to the `site-deploy` phase. For those, the whole command is:

```
mvn -Preporting clean verify site-deploy
```

That covers plexus-utils, plexus-xml, plexus-io, plexus-archiver, plexus-interpolation, plexus-classworlds, plexus-testing, plexus-i18n, plexus-resources and plexus-velocity.

**Multi-module repositories need staging first**, because the site has to be assembled across modules before it is pushed:

```
mvn -Preporting clean verify site site:stage scm-publish:publish-scm
```

That covers modello, plexus-compiler, plexus-languages and plexus-interactivity.

The `-Preporting` profile is what adds the Javadoc, JXR and surefire reports. Without it you publish a site with no API documentation, which is worse than not republishing at all.

## Publishing from GitHub Actions

Every project has a **Publish Site** workflow, run from the Actions tab. It does the same thing as the commands above, so you do not need a local checkout or credentials:

- **multi-module** — set by the caller workflow, not by you
- **dry-run** — builds the site and checks out `gh-pages` without committing. Worth using the first time you publish a given project.

The job token pushes to that repository's own `gh-pages`; there is no secret to configure.

### Why it isn't automatic

The workflow is triggered by hand rather than on release. Publishing puts content live with no review step, and Maven site builds break often enough — doxia, site plugin and JDK interactions — that we would rather a person saw the output before it goes up.

## Snapshot deployment

The shared `maven-deploy.yml` workflow currently has snapshot publishing disabled (the step is a placeholder that echoes and exits). Don't rely on snapshots being on Central; build locally with `mvn install` instead.
