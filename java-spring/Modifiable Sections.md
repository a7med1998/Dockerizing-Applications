# Modifiable Sections in Dockerfile

This document outlines the sections of the Dockerfile that can be customized to fit different requirements, along with explanations for each part.

---

## 1. Base Build Image - `FROM maven:3.8.6-openjdk-17 AS build`

- **Description**: Defines the base image for building the application. Here, we use Maven with JDK 17.
- **Modifiable Part**: You can change `maven:3.8.6-openjdk-17` to use a different version of Maven or a different JDK version, depending on your application’s requirements.
- **Example Modification**: If you need JDK 11 instead of 17, change to `maven:3.8.6-openjdk-11`.

---

## 2. Working Directory - `WORKDIR /app`

- **Description**: Sets the working directory inside the container, which is where files and commands will be executed.
- **Modifiable Part**: Change `/app` to a different path if you want to organize your files differently within the container.
- **Example Modification**: If you want to use `/usr/src/app`, update this line to `WORKDIR /usr/src/app` and adjust subsequent paths accordingly.

---

## 3. Copying Application Files - `COPY pom.xml ./` and `COPY src ./src`

- **Description**: Copies the `pom.xml` (Maven configuration) and `src` (source code) into the container.
- **Modifiable Part**: If you have a different directory structure, you may need to adjust these paths to match your project's layout.
- **Example Modification**: If your source files are in a folder named `app-source` instead of `src`, modify `COPY src ./src` to `COPY app-source ./app-source`.

---

## 4. Build Command - `RUN mvn clean package -DskipTests`

- **Description**: Runs the Maven command to build the application and create a JAR file. Here, tests are skipped for faster builds.
- **Modifiable Part**: You can choose to include tests or change the Maven goals according to your needs.
- **Example Modification**: Remove `-DskipTests` if you want to include tests, or replace `clean package` with another goal like `install` or `verify`.

---

## 5. Base Runtime Image - `FROM openjdk:17-jdk-alpine`

- **Description**: Specifies the base image for the runtime environment where the application will run.
- **Modifiable Part**: If a different JDK version or image type is required, you can modify this line.
- **Example Modification**: Change `openjdk:17-jdk-alpine` to `openjdk:11-jdk` if the application only supports JDK 11.

---

## 6. Copying the JAR file - `COPY --from=build /app/target/myapp.jar /app/myapp.jar`

- **Description**: Copies the built JAR file from the build stage into the runtime environment.
- **Modifiable Part**: Update the path if the JAR file name or location changes after building.
- **Example Modification**: If the generated JAR file is named `springapp.jar`, modify this line to `COPY --from=build /app/target/springapp.jar /app/springapp.jar`.

---

## 7. Exposed Port - `EXPOSE 8080`

- **Description**: Specifies the port on which the application will listen inside the container.
- **Modifiable Part**: If your application uses a different port, change this to match.
- **Example Modification**: If your application runs on port 9090, modify this line to `EXPOSE 9090`.

---

## 8. Start Command - `CMD ["java", "-jar", "/app/myapp.jar"]`

- **Description**: Sets the default command to start the Spring Boot application by running the JAR file.
- **Modifiable Part**: Change the path if the JAR file name or location is different, or add Java options if required.
- **Example Modification**: If the JAR is named `springapp.jar`, change this line to `CMD ["java", "-jar", "/app/springapp.jar"]`. Add options like `-Xmx512m` to set memory limits if needed.
