# Specify the Dart SDK base image version using dart:<version>
FROM dart:stable AS build

# Resolve app dependencies.
WORKDIR /intR64
COPY pubspec.* ./
RUN dart pub get

# Copy app source code 
COPY . .
# Compile 
RUN dart pub get --offline
RUN dart compile exe /intR64/src/main.dart -o /intR64/src/main

FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /intR64/src/main /intR64/bin/

LABEL maintainer="Rafael <marleirafa@gmail.com>"

# Start intR64.
CMD [ "/intR64/bin/main", "/var/rinha/source.rinha.json"]

