#Use an existing docker image as base  and tag as builder .. 
# everything below wil be referred as builder

FROM node:alpine as builder

#Workdir - for copying file to container
WORKDIR '/app'

#Download and install a dependency
COPY package.json .
RUN npm install
COPY . .

# This will create build folder  and this folder is needed in run phase
RUN npm run build

#finished builder  step

FROM nginx

# Expose is needed for EBS AWS to listen on port 80  it WIll map to this port
EXPOSE 80
# copy build folder from builder phase
COPY --from=builder /app/build /usr/share/nginx/html