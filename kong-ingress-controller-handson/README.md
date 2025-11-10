# Self-learning project: Kong API Gateway

## Introduction
This project is to get hands-on experience on Kong API Gateway by solving a problem.

During the project, the following concepts will be explored:
- Installing Kong on Kubernetes
- Routing web application requests with Kong and HTTPRoute
- Defining authenticated identity with Kong Consumer and Consumer Group
- Authentication using Kong plugins: JWT, API key
- Rate limiting with Kong
- Authorization to specifc URI with Kong access control list (ACL)

## Problem
We want to use Kong as an API Gateway to route traffic to 2 services: echo-service and task-service.

There are 2 types of identity that will call to those services:
- Developers: Lucas, Anna
- Contractors: Alex, Henry
- Individual administrators: Louis, Tom

The developers can be authenticated to Kong and call to any API they want. The rate limit for developers is 10RPS.
The contractors can only be authenticated to Kong and call to specific URIs of the task-service. The rate limit for contractors is 5RPS.

## Installing Kong on Kubernetes

TBD

## Routing requests with Kong and HTTPRoute

TBD

## Defining authenticated identity with Kong Consumer and Consumer Group
