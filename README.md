# OpenAPI (Swagger) Sample Spec for MTConnect
MTConnect is a read-only protocol for facilitating the exchange of data between shop floor equipment and software applications.

It emits data represented in XML. The schemas for the entities represented by MTConnect are here: https://github.com/mtconnect/schema.

When I first encountered the standard, I got excited about how it is easy to surface data from the shop floor for immediate consumption. It is basically just making REST calls to an agent that provides the data from the equipment connected to it.

As I explored the standard further, as it is defined on http://www.mtconnect.org/, I noticed there are no Swagger (OpenAPI) specifications for the API. So I decided to put together one.

More reading on OpenAPI is here, https://www.openapis.org/. Once you have a specification of the API, it is easy to generate stub code for a service, and a client library for it.

## Story

As I started working on this project during a weekend, I encountered a few things.

* **Swagger 2.0 or OpenAPI 3.0**: OpenAPI 3.0 release is quite recent, and the code generators are not complete (as of April 2018). This forced me to use Swagger 2.0.
* **Response schemas in Swagger**: MTConnect standard specifies the schema for the data return in various GET requests in XSD. However, Swagger has been know to have not so much great support for external XSD schemas. It only supports a subset of JSON schema draft 4.0. I tried generating POCO classes using Visual Studio's xsd.exe command, and subsequently generating JSON schemas using Newtonsoft.Json.Schema (https://www.nuget.org/packages/Newtonsoft.Json.Schema/), but they lost fidelity. I opted for using object type, with format on the Swagger spec, so I can further deserialize the result into POCO's.
* **POCO types for the results**: They are generated using xsd.exe, however each schema refers to the same Header type. I had to manually remove them from the generated files, and create a single type for the Header.
* **MTConnect version**: MTConnect Institute recently released version 1.4, however most of the data out there is using version 1.3.1. The first spec I attempted is for 1.3.1.

## Some Suggestions to the MTConnect Community

1. Write the spec for 1.4
2. Translate XSDs to YAML or JSON equivalents for Swagger specs.

## Limitations

* Swagger 2.0 does not support matrix type parameters. The protocol specification includes a request for multiple assets by id in the form of "http://example.com/asset/hh1;cc;123;g5". This request type is not implemented in the Swagger spec. A workaround is to request assets one by one.