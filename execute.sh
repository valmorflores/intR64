sudo docker build --tag 'intr64compile' .
sudo docker run -v /var/rinha/source.rinha.json:/var/rinha/source.rinha.json intr64compile:latest