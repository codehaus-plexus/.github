# Codehaus Plexus

Small, focused Java libraries that Apache Maven and its plugins are built on — archive handling, compiler abstraction, file I/O, XML, string interpolation, classloader management and code generation.

If you write Maven plugins, you almost certainly depend on several of these already, usually transitively. They are maintained by the Apache Maven community.

**Documentation:** <https://codehaus-plexus.github.io/> · **Javadoc:** [javadoc.io](https://javadoc.io/doc/org.codehaus.plexus)

### A note on the name

Plexus originally had two halves: an IoC container and a set of components for it. **The container is retired.** Maven moved to [Eclipse Sisu](https://www.eclipse.org/sisu/) and [JSR-330](https://jcp.org/en/jsr/detail?id=330) years ago, and nothing here needs a Plexus container to run — the components are ordinary JSR-330 beans.

What remains, and what this organisation is now, is the second half: the libraries below. The old container documentation is kept on the site for historical reference, because plenty of writing from that era still links to it.

## Libraries

| Artifact | Version | What it does |
|---|---|---|
| [plexus-utils](https://github.com/codehaus-plexus/plexus-utils) | [![v](https://img.shields.io/maven-central/v/org.codehaus.plexus/plexus-utils?label=)](https://central.sonatype.com/artifact/org.codehaus.plexus/plexus-utils) | Utilities for strings, files, command lines and process execution |
| [plexus-xml](https://github.com/codehaus-plexus/plexus-xml) | [![v](https://img.shields.io/maven-central/v/org.codehaus.plexus/plexus-xml?label=)](https://central.sonatype.com/artifact/org.codehaus.plexus/plexus-xml) | XML classes split out of plexus-utils 4 (`Xpp3Dom` and friends) |
| [plexus-io](https://github.com/codehaus-plexus/plexus-io) | [![v](https://img.shields.io/maven-central/v/org.codehaus.plexus/plexus-io?label=)](https://central.sonatype.com/artifact/org.codehaus.plexus/plexus-io) | File and resource abstractions, selectors and mappers |
| [plexus-interpolation](https://github.com/codehaus-plexus/plexus-interpolation) | [![v](https://img.shields.io/maven-central/v/org.codehaus.plexus/plexus-interpolation?label=)](https://central.sonatype.com/artifact/org.codehaus.plexus/plexus-interpolation) | Resolves `${...}` expressions — the engine behind POM interpolation |
| [plexus-classworlds](https://github.com/codehaus-plexus/plexus-classworlds) | [![v](https://img.shields.io/maven-central/v/org.codehaus.plexus/plexus-classworlds?label=)](https://central.sonatype.com/artifact/org.codehaus.plexus/plexus-classworlds) | Classloader management; how Maven isolates plugins from itself |

## Components

| Artifact | Version | What it does |
|---|---|---|
| [plexus-archiver](https://github.com/codehaus-plexus/plexus-archiver) | [![v](https://img.shields.io/maven-central/v/org.codehaus.plexus/plexus-archiver?label=)](https://central.sonatype.com/artifact/org.codehaus.plexus/plexus-archiver) | One API over zip, jar, tar, and their compressed variants |
| [plexus-compiler](https://github.com/codehaus-plexus/plexus-compiler) | [![v](https://img.shields.io/maven-central/v/org.codehaus.plexus/plexus-compiler-api?label=)](https://central.sonatype.com/artifact/org.codehaus.plexus/plexus-compiler-api) | One API over javac, ECJ, AspectJ and others — used by maven-compiler-plugin |
| [plexus-languages](https://github.com/codehaus-plexus/plexus-languages) | [![v](https://img.shields.io/maven-central/v/org.codehaus.plexus/plexus-java?label=)](https://central.sonatype.com/artifact/org.codehaus.plexus/plexus-java) | Reads `module-info` and splits the classpath from the module path (`plexus-java`) |
| [plexus-sec-dispatcher](https://github.com/codehaus-plexus/plexus-sec-dispatcher) | [![v](https://img.shields.io/maven-central/v/org.codehaus.plexus/plexus-sec-dispatcher?label=)](https://central.sonatype.com/artifact/org.codehaus.plexus/plexus-sec-dispatcher) | Encrypts and decrypts passwords in `settings.xml` |
| [plexus-resources](https://github.com/codehaus-plexus/plexus-resources) | [![v](https://img.shields.io/maven-central/v/org.codehaus.plexus/plexus-resources?label=)](https://central.sonatype.com/artifact/org.codehaus.plexus/plexus-resources) | Reads a resource from the filesystem, the classpath or a URL |
| [plexus-velocity](https://github.com/codehaus-plexus/plexus-velocity) | [![v](https://img.shields.io/maven-central/v/org.codehaus.plexus/plexus-velocity?label=)](https://central.sonatype.com/artifact/org.codehaus.plexus/plexus-velocity) | Apache Velocity integration |
| [plexus-i18n](https://github.com/codehaus-plexus/plexus-i18n) | [![v](https://img.shields.io/maven-central/v/org.codehaus.plexus/plexus-i18n?label=)](https://central.sonatype.com/artifact/org.codehaus.plexus/plexus-i18n) | Resource-bundle lookup for localised messages |
| [plexus-interactivity](https://github.com/codehaus-plexus/plexus-interactivity) | [![v](https://img.shields.io/maven-central/v/org.codehaus.plexus/plexus-interactivity-api?label=)](https://central.sonatype.com/artifact/org.codehaus.plexus/plexus-interactivity-api) | Prompts the user on the console |
| [plexus-build-api](https://github.com/codehaus-plexus/plexus-build-api) | [![v](https://img.shields.io/maven-central/v/org.codehaus.plexus/plexus-build-api?label=)](https://central.sonatype.com/artifact/org.codehaus.plexus/plexus-build-api) | Lets plugins report file changes to an incremental build (m2e) |

## Tooling

| Artifact | Version | What it does |
|---|---|---|
| [modello](https://github.com/codehaus-plexus/modello) | [![v](https://img.shields.io/maven-central/v/org.codehaus.modello/modello-maven-plugin?label=)](https://central.sonatype.com/artifact/org.codehaus.modello/modello-maven-plugin) | Generates Java classes, readers/writers, XSD and docs from one model file. MIT-licensed |
| [plexus-testing](https://github.com/codehaus-plexus/plexus-testing) | [![v](https://img.shields.io/maven-central/v/org.codehaus.plexus/plexus-testing?label=)](https://central.sonatype.com/artifact/org.codehaus.plexus/plexus-testing) | JUnit 5 support for testing JSR-330 components |
| [plexus-pom](https://github.com/codehaus-plexus/plexus-pom) | [![v](https://img.shields.io/maven-central/v/org.codehaus.plexus/plexus?label=)](https://central.sonatype.com/artifact/org.codehaus.plexus/plexus) | The parent POM every project here inherits |

## Retired

These repositories are archived and receive no fixes, including security fixes. Don't start anything new on them.

| Repository | What to use instead |
|---|---|
| [plexus-containers](https://github.com/codehaus-plexus/plexus-containers) | [Eclipse Sisu](https://www.eclipse.org/sisu/) with JSR-330 annotations |
| [plexus-cipher](https://github.com/codehaus-plexus/plexus-cipher) | [plexus-sec-dispatcher](https://github.com/codehaus-plexus/plexus-sec-dispatcher) 4.x, which absorbed it |
| [plexus-component-factories](https://github.com/codehaus-plexus/plexus-component-factories) | Nothing — a container concern that no longer exists |
| [plexus-maven-plugin](https://github.com/codehaus-plexus/plexus-maven-plugin) | Nothing — generated container descriptors, obsolete under Sisu |
| [plexus-digest](https://github.com/codehaus-plexus/plexus-digest) | `java.security.MessageDigest`, or Commons Codec |
| [plexus-cli](https://github.com/codehaus-plexus/plexus-cli) | Commons CLI, picocli |
| [plexus-swizzle](https://github.com/codehaus-plexus/plexus-swizzle) | Nothing |
| [plexus-components](https://github.com/codehaus-plexus/plexus-components) | Split into the individual repositories above |

## Contributing

Issues and pull requests are welcome on each repository. Start with [CONTRIBUTING.md](https://github.com/codehaus-plexus/.github/blob/master/CONTRIBUTING.md) — it covers building, the Java baseline and code formatting, which is enforced by the build.

To report a security vulnerability, please follow [SECURITY.md](https://github.com/codehaus-plexus/.github/blob/master/SECURITY.md) rather than opening a public issue.

Everything here is Apache-2.0 except Modello, which is MIT.
