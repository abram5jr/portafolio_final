# Etapa 1: Compilación usando Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
# Copia tu archivo de dependencias y el código fuente
COPY pom.xml .
COPY src ./src
# Compila el proyecto generando el archivo .war
RUN mvn clean package -DskipTests

# Etapa 2: Servidor Tomcat para ejecutar la app
FROM tomcat:9.0-jre17
# Limpiamos las apps por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*
# Copiamos tu proyecto compilado y lo renombramos a ROOT.war para que abra directamente
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Exponemos el puerto web
EXPOSE 8080
CMD ["catalina.sh", "run"]
