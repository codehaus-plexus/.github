# Contributing to Codehaus Plexus

This applies to every repository in the [codehaus-plexus](https://github.com/codehaus-plexus) organisation.

These libraries sit underneath Apache Maven and most of its plugins, so a regression here reaches a very long way. That shapes the advice below more than any style preference does.

## Where to ask

**GitHub Issues, on the repository concerned.** That is where the maintainers are. There is no Plexus mailing list — if you find one referenced in older documentation, it is defunct.

If you aren't sure which repository owns the behaviour you're seeing, open the issue wherever seems closest and we'll move it.

## Building

```
mvn verify
```

That's it — no profile or local setup required. CI runs the equivalent of:

```
mvn --batch-mode --errors --show-version verify javadoc:javadoc
```

across JDK 8, 21 and 25 on Linux, Windows and macOS, using Maven 3.9.11. If your change builds on your machine but you can't easily test the other JDKs, open the pull request anyway and let CI tell you.

Use **Maven 3.9.0 or later**. Releases have required it for some time; from `plexus-pom` 27 the ordinary
build enforces it as well, so an older Maven fails at `enforce-maven-version` rather than part-way through.
This is a build-side requirement only — it says nothing about the Maven version that can consume the
released artifacts.

Some repositories have integration tests behind a profile, usually `-Prun-its`. Check the repository's own README.

## Java baseline

Most projects still target **Java 8**, inherited from the parent POM. A few have moved on — `plexus-sec-dispatcher` and `plexus-xml` 4.x require **Java 17**, in step with Maven 4.

Check the `javaVersion` property in the project's `pom.xml` before reaching for a newer API. Raising a baseline is a deliberate, separate decision, not something to slip into a feature PR.

## Formatting

Formatting is enforced by the build, so don't hand-format and don't reformat code you aren't otherwise touching:

```
mvn spotless:apply
```

This applies [palantir-java-format](https://github.com/palantir/palantir-java-format), sorts imports, and tidies POMs. If CI fails on `spotless:check`, running the command above and committing the result is the whole fix.

You may still find older documentation telling you to import `maven-eclipse-codestyle.xml` or `maven-idea-codestyle.xml` into your IDE. That predates Spotless and no longer reflects what the build enforces.

## Licence headers

New files need the standard Apache-2.0 header used by the surrounding files in that repository. Modello is MIT — match what's already in the file you're next to.

Please **don't** update or "normalise" existing copyright headers, including the older `Codehaus Foundation` ones. They record who contributed what, and changing them is not ours to do.

## Pull requests

- One concern per pull request. Mechanical cleanups and behaviour changes in the same diff are much harder to review and much slower to merge.
- Explain *why* in the description. The what is visible in the diff.
- Add a test. If the change is genuinely untestable, say so and why.
- Keep public API compatible. These artifacts are consumed transitively by essentially the whole Maven plugin ecosystem, so a source- or binary-incompatible change needs discussion in an issue first. Deprecate rather than remove; the deprecation javadoc should say what to use instead.
- Reference the issue the PR addresses, if there is one.

Maintainers may squash on merge, so don't worry about a tidy commit history within a branch.

## Reporting a bug

The useful ones say which version you're on, which JDK and Maven version, what you expected, and what happened instead. A short reproducer beats a long description. If it involves a build failure, the output of `mvn -e` helps.

## Security

Please don't open a public issue for a vulnerability. See [SECURITY.md](SECURITY.md).

## For maintainers

Releasing and site publishing are documented in [RELEASING.md](RELEASING.md).
