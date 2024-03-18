#Build Stage defined 
FROM node:20 AS build

WORKDIR /app
#copy from Local machine to docker
COPY . .
#Dependecies installed and defined 
RUN npm install --force
RUN npm i -g @angular/cli
RUN npm install -g angular-http-server

#Create dist folder 
RUN npm run build

#Deployment with configuration with Nginx
FROM nginx:alpine
#Copy from previous stage Dist to this 
COPY --from=build /app/dist/resumebuilder /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]