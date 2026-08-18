# Contributing to Codehaus Plexus

This applies to every repository in the [codehaus-plexus](https://github.com/codehaus-plexus) organization.

These libraries sit underneath Apache Maven and most of its plugins, so a regression here reaches most of the ecosystem. That shapes the advice below more than any style preference does.

## Where to ask

**GitHub Issues, on the repository concerned.** That is where the maintainers are. There is no Plexus mailing list. If you find one referenced in older documentation, it is defunct.

If you aren't sure which repository owns the behavior you're seeing, open the issue wherever seems closest and we'll move it.

## Build a project

To build any repository here:

```
mvn verify
```

No profile or local setup is required. CI runs the equivalent of the following:

```
mvn --batch-mode --errors --show-version verify javadoc:javadoc
```

CI runs that across JDK 8, 21, and 25 on Linux, Windows, and macOS, using Maven 3.9.11. If your change builds on your machine but you can't test the other JDKs, open the pull request anyway and read the CI result.

Use Maven 3.9.0 or later. Releases have required it for some time, and from `plexus-pom` 27 the ordinary build enforces it as well, so an older Maven fails at `enforce-maven-version` rather than part-way through. This is a build-side requirement only. It says nothing about the Maven version that can consume the released artifacts.

Some repositories keep integration tests behind a profile, usually `-Prun-its`. Check the repository's own README file.

## Java baseline

Most projects target Java 8, inherited from the parent POM. A few have moved on: `plexus-sec-dispatcher` and `plexus-xml` 4.x require Java 17, in step with Maven 4.

Check the `javaVersion` property in the project's `pom.xml` file before reaching for a newer API. Raising a baseline is a deliberate, separate decision, not something to slip into a feature pull request.

## Format your code

The build enforces formatting, so don't hand-format, and don't reformat code you aren't otherwise touching. To format:

```
mvn spotless:apply
```

That command applies [palantir-java-format](https://github.com/palantir/palantir-java-format), sorts imports, and tidies POM files. When CI fails on `spotless:check`, running the command and committing the result is the whole fix.

Older documentation tells you to import the `maven-eclipse-codestyle.xml` or `maven-idea-codestyle.xml` file into your IDE. That advice predates Spotless and no longer reflects what the build enforces.

## License headers

A new file needs the standard Apache-2.0 header used by the files around it in that repository. Modello is MIT, so match the file you're next to.

Don't update or normalize an existing copyright header, including the older `Codehaus Foundation` ones. They record who contributed what, and changing them is not ours to do.

## Pull requests

A pull request is easier to review when it does the following:

- Covers one concern. Mechanical cleanups and behavior changes in the same diff are harder to review and slower to merge.
- Explains why in the description. The what is visible in the diff.
- Adds a test. If the change is genuinely untestable, say so and say why.
- Keeps the public API compatible. The whole Maven plugin ecosystem consumes these artifacts transitively, so a source-incompatible or binary-incompatible change needs discussion in an issue first. Deprecate rather than remove, and say in the deprecation javadoc what to use instead.
- References the issue it addresses, if there is one.

Maintainers may squash on merge, so a tidy commit history within a branch isn't necessary.

## Report a bug

The most useful reports say which version you're on, which JDK and Maven version you use, what you expected, and what happened instead. A short reproducer is worth more than a long description. For a build failure, include the output of `mvn -e`.

## Security

Don't open a public issue for a vulnerability. For the process, see [SECURITY.md](SECURITY.md).

## For maintainers

For releasing and site publishing, see [RELEASING.md](RELEASING.md).
