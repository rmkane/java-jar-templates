# Sample Java Project

Initial setup:

- <https://dzone.com/articles/java-8-how-to-create-executable-fatjar-without-ide>

## Compile and run

```shell
mkdir -p build/classes
javac -sourcepath src -d build/classes src/oata/HelloWorld.java
java -cp build/classes oata.HelloWorld
```

## Build jar

```shell
echo Main-Class: oata.HelloWorld>myManifest
mkdir -p build/jar
jar cfm build/jar/HelloWorld.jar myManifest -C build/classes .
java -jar build/jar/HelloWorld.jar
```

## Clean

```shell
rm -rf build
```

## Dependencies

- `org.apache.logging.log4j:log4j-api:2.19.0`
- `org.apache.logging.log4j:log4j-core:2.19.0`
- `org.apache.logging.log4j:log4j-slf4j-impl:2.19.0`

### Peers

- `org.slf4j:slf4j-api:1.7.25` (required)
