# docker-tomcat-spring-example

[![Build Status](https://travis-ci.org/kerphi/docker-tomcat-spring-example.svg?branch=master)](https://travis-ci.org/kerphi/docker-tomcat-spring-example) [![CircleCI](https://circleci.com/gh/kerphi/docker-tomcat-spring-example.svg?style=svg)](https://circleci.com/gh/kerphi/docker-tomcat-spring-example)

Ce dépôt est un exemple de dockerisation d'une application spring-boot compilée dans un war via [l'image docker officielle maven](https://hub.docker.com/_/maven) puis déployée et exécutée dans un [tomcat via son image docker officielle](https://hub.docker.com/_/tomcat).


## Construire l'application

```shell
docker-compose -f docker-compose.build.yml build
```

L'image docker `docker-tomcat-spring-example:1.0.0` sera alors construite localement. A noter que si les source Java de l'application (répertoire `src/`) sont modifiées, les dépendances maven ne seront pas retéléchagées (ce qui prend du temps) car elles ont été mise en cache par le système multistage-build de docker. Le dépendances seront retéléchargées uniquement si `pom.xml` est modifié.

La fonctionnalité [multistage-build de docker](https://docs.docker.com/engine/userguide/eng-image/multistage-build/) est utilisée dans la phase `docker build`. Cette phase procède en deux étapes :
- compilation du WAR via un premier conteneur docker indépendant doté de maven et du JDK
- copie du WAR (sans son environnement de build) dans l'image docker cible qui est elle dotée uniquement d'un tomcat

## Exécuter l'application

```shell
docker-compose up
```

Le conteneur docker nommé `docker-tomcat-spring-example` est alors créé à partir de l'image docker`docker-tomcat-spring-example:1.0.0` préalablement construite. Le WAR est alors automatiquement déployé et executé par tomcat à sa racine. L'application spring-boot est alors accessible dans le serveur web de tomcat qui est à l'écoute sur le port local 8080 : http://localhost:8080/

Pour stopper l'application utiliser `CTRL+C`
