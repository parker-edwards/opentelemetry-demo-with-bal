# Project Description
This is a fork of the official OpenTelemetry Microservices Demo application, with an additional service written in Ballerina.

## Architecture

```mermaid
graph TD
subgraph Service Diagram
adservice(Ad Service):::java
cache[(Cache<br/>&#40redis&#41)]
cartservice(Cart Service):::dotnet
checkoutservice(Checkout Service):::golang
currencyservice(Currency Service):::cpp
emailservice(Email Service):::ruby
frontend(Frontend):::javascript
frontendproxy(Frontend Proxy <br/>&#40Envoy&#41):::cpp
loadgenerator([Load Generator]):::python
mailcheckservice([Mailcheck Service]):::ballerina
paymentservice(Payment Service):::javascript
productcatalogservice(Product Catalog Service):::golang
quoteservice(Quote Service):::php
recommendationservice(Recommendation Service):::python
shippingservice(Shipping Service):::rust
featureflagservice(Feature Flag Service):::erlang
featureflagstore[(Feature Flag Store<br/>&#40PostgreSQL DB&#41)]
Internet -->|HTTP| frontendproxy
frontendproxy -->|HTTP| frontend
frontendproxy -->|HTTP| featureflagservice
loadgenerator -->|HTTP| frontend
checkoutservice --->|gRPC| cartservice --> cache
checkoutservice --->|gRPC| productcatalogservice
checkoutservice --->|gRPC| currencyservice
checkoutservice --->|HTTP| emailservice --->|HTTP| mailcheckservice
checkoutservice --->|gRPC| paymentservice
checkoutservice -->|gRPC| shippingservice
frontend -->|gRPC| adservice
frontend -->|gRPC| cartservice
frontend -->|gRPC| productcatalogservice
frontend -->|gRPC| checkoutservice
frontend -->|gRPC| currencyservice
frontend -->|gRPC| recommendationservice -->|gRPC| productcatalogservice
frontend -->|gRPC| shippingservice -->|HTTP| quoteservice
productcatalogservice -->|gRPC| featureflagservice
shippingservice -->|gRPC| featureflagservice
featureflagservice --> featureflagstore
end
classDef java fill:#b07219,color:white;
classDef dotnet fill:#178600,color:white;
classDef golang fill:#00add8,color:black;
classDef cpp fill:#f34b7d,color:white;
classDef ruby fill:#701516,color:white;
classDef python fill:#3572A5,color:white;
classDef javascript fill:#f1e05a,color:black;
classDef rust fill:#dea584,color:black;
classDef erlang fill:#b83998,color:white;
classDef php fill:#4f5d95,color:white;
classDef ballerina fill:#a0a2a2,color:white;
```

```mermaid
graph TD
subgraph Service Legend
  ballerinasvc(Ballerina):::ballerina
  javasvc(Java):::java
  dotnetsvc(.NET):::dotnet
  golangsvc(Go):::golang
  cppsvc(C++):::cpp
  rubysvc(Ruby):::ruby
  pythonsvc(Python):::python
  javascriptsvc(JavaScript):::javascript
  rustsvc(Rust):::rust
  erlangsvc(Erlang/Elixir):::erlang
  phpsvc(PHP):::php
end
classDef java fill:#b07219,color:white;
classDef dotnet fill:#178600,color:white;
classDef golang fill:#00add8,color:black;
classDef cpp fill:#f34b7d,color:white;
classDef ruby fill:#701516,color:white;
classDef python fill:#3572A5,color:white;
classDef javascript fill:#f1e05a,color:black;
classDef rust fill:#dea584,color:black;
classDef erlang fill:#b83998,color:white;
classDef php fill:#4f5d95,color:white;
classDef ballerina fill:#a0a2a2,color:white;
```

# Remaining Tasks
## High priority
[ ] Change the service name in the Ballerina API from `/` to `mailcheckservice` in alignment with other services
[ ] Fork the *ballerinax/jaeger* module, add a configurable context propagator (supporting jaeger format by default, which is the current state, as well as the W3C propagator), and build a snapshot of the module
[ ] Pull the snapshot *ballerinax/jaeger* module featuring W3C propagator support into `mailcheckservice` image and deploy to Docker
[ ] Confirm traces are connected as intended

## Non-critical
[ ] File issue in the *ballerinax/jaeger* module repo explaining the current implementation of context propagators as well as the need for a (currently missing) W3C propagator
[ ] Submit PR for the *ballerinax/jaeger* module 
[ ] Provide tiltfile to help automate the local deployment of the demo onto a Kubernetes cluster with included OpenTelemetry monitoring