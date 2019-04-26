# docker-tomcat-spring-example

Un exemple de dockerisation d'une application sprint-boot compilée dans un war via [l'image docker officielle maven](https://hub.docker.com/_/maven) puis déployée et exécutée dans un [tomcat via son image docker officielle](https://hub.docker.com/_/tomcat).

La fonctionnalité [multistage-build de docker](https://docs.docker.com/engine/userguide/eng-image/multistage-build/) est ici utilisée pour pouvoir compiler le WAR dans un premier conteneur docker indépendant puis de le déployer (sans son environnement de build) dans un autre conteneur qui est lui uniquement chargé d'exécuter un tomcat.

```shell
docker build --tag docker-tomcat-spring-example .
docker run --rm -p 8080:8080 docker-tomcat-spring-example
```
