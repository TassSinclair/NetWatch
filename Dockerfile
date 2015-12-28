FROM node:5

RUN useradd -m node && \
	apt-get update && \
	apt-get install -y nmap

ENV HOME /home/node

COPY . /home/node/app/
WORKDIR /home/node/app/
RUN chown node: . -R 
USER node
RUN npm install

CMD ["npm", "start"]
EXPOSE 3000