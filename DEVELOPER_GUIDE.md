## Developer Guide

### Requirements

`bash` and `zip` is all you need to build the package.

```console
bash scripts/pack.sh
```

There is a `Makefile` and a `Dockerfile` to for convenience, but it's not really necessary to use them.


The Dockerfile contains all the requirements to run this software.

- Docker 24.0.0+ (probably works with previous versions too)

Change the version accordingly.
```console
docker build -t fh2-uncensored-texture-pack:2.63 .
docker run -v "$(pwd)":/app fh2-uncensored-texture-pack:2.63
```

To test the GitHub actions locally, you will Act:

```console
act -e .github/workflows/tag.json --artifact-server-path dist
```

or using the Make shorthand:

```console
make test
```

Note that it will eventually fail because the GitHub token is not set, but it still useful
to test the workflow locally and find for most of the errors.

### Versioning

The versioning followed in this project follow the mod's versioning to easily identify the
package required for each version of the mod. We use a third number to identify the version of
the package itself, inside the same version of the mod. This is useful to fix bugs or add new
features without having to change the version of the mod itself.

Pattern: `2.XY.Z`, eg: `2.63.0, 2.63.1`

### Releasing a new version

The texture pack might be broken between versions of the mod. Test, and if required fix the 
texture pack before generating a release.


1. Bump the version:
    ```console
    bash scripts/version.sh 2.XY.Z
    ```

2. Create a tag:
    ```console
    git tag -a v2.XY.Z -m "Release v2.XY.Z"
    git push origin v2.XY.Z
    ```

3. If everything goes fine, the release will be created automatically in GitHub.
