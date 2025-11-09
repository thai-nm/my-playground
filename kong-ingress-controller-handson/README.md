# Self-learning project: Kong API Gateway

## Introduction
This project is to get hands-on experience on Kong API Gateway using Kong Ingress Controller Helm chart to install and manage Kong on Kubernetes.

This project will explore the following concepts:
- Installing Kong on Kubernetes
- Routing web application requests with Kong and HTTPRoute
- Defining authenticated identity with Kong Consumer and Consumer Group
- Authentication using Kong plugins: JWT, API key
- Rate limiting with Kong
- Authorization to specifc URI with Kong access control list (ACL)

## Installing Kong on Kubernetes

TBD

## Routing requests with Kong and HTTPRoute

TBD

## Defining authenticated identity with Kong Consumer and Consumer Group

We will have the following Consumer Groups (CMG) and Consumers (CM):
- developer: lucas, anna
- contractor: bob, henry

Developer Consumer Group is able to call to every APIs.
Contractor Consumer Group is only able to call to specific paths in task service APIs.

At this stage we will only create Consumers and Consumer Groups. Access control will be adjusted later.