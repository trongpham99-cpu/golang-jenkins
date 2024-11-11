# Use Golang base image
FROM golang:1.18-alpine AS build

WORKDIR /app

# Copy go.mod and go.sum
COPY go.mod ./
COPY go.sum ./
RUN go mod download

# Copy source files and build the app
COPY . .
RUN go build -o /golang-app

# Use a minimal image for the final stage
FROM alpine:latest
COPY --from=build /golang-app /golang-app
ENTRYPOINT ["/golang-app"]

