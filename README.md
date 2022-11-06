
<p align="center">
  <img src="https://github.com/kspalaiologos/kamilalisp/raw/v0.2/doc/logo.png">
</p>


# KamilaLisp Two: Electric Boogaloo

A functional, flexible and concise Lisp inspired by Haskell and APL, among others. A ground-up rewrite.

Useful links:

- **[Channel on the /r/PL Discord server](https://discord.gg/xr5VapADw7)**

## Setup

You need Java17 GraalVM 22.2 installed to build KamilaLisp yourself. Make sure that `PATH`, `GRAALVM_HOME`, and `JAVA_HOME` are set approperiately. Additionally, make sure that `native-image` is installed via `gu`. Alternatively, you could download a from our Jenkins.

```
git clone https://github.com/kspalaiologos/kamilalisp
cd kamilalisp
mvn package              # If you want to build a JAR file.
mvn package -P native    # If you want to build a native image.
```

WIP: Further instructions.

## License

KamilaLisp is distributed under the GNU General Public License v3. See [LICENSE](https://github.com/kspalaiologos/kamilalisp/blob/main/LICENSE) for details.
