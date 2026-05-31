# PuzzleWeb

<img src="https://github.com/dvaumoron/puzzle/web/raw/main/logo/puzzlelogo.jpg" width="100">

PuzzleWeb is a microservice backed server allowing to include static content, blog, wiki, forum and custom "widget" with role based right management, user profile, user settings, and [i18n](https://www.w3.org/International/questions/qa-i18n.en#i18n).

## License

All of the project in the Puzzle ecosystem are released under the Apache 2.0 license. See [LICENSE](LICENSE).

## Getting started

The project [PuzzleWeaver](https://github.com/dvaumoron/puzzle/weaver) allows to use PuzzleWeb features with a single binary (a modular monolith done with [ServiceWeaver](https://serviceweaver.dev/) and configured with [puzzleweaver.toml](https://github.com/dvaumoron/puzzle/test/blob/main/puzzleweaver.toml)).

Install via [Homebrew](https://brew.sh/)

```console
$ brew tap dvaumoron/tap
$ brew install puzzleweaver
```

Or get the [last binary](https://github.com/dvaumoron/puzzle/weaver/releases) depending on your OS.

Then you need testing resources (see [PuzzleTest](https://github.com/dvaumoron/puzzle/test)) and datastores (PuzzleWeaver and PuzzleWeb rely on SQL databases, [MongoDB](https://www.mongodb.com/) instances and [Redis](https://redis.io/) instances)

Finally, you can run it with the command :

    weaver single deploy puzzleweaver.toml

You can use PuzzleWeb directly (however you will have to manage [gRPC](https://grpc.io/) servers for all services).

[PuzzleTest](https://github.com/dvaumoron/puzzle/test) contains test resources (configurations : [frame.hcl](https://github.com/dvaumoron/puzzle/test/blob/main/frame.hcl), page templates and localisation files : [templatedata](https://github.com/dvaumoron/puzzle/test/blob/main/templatedata), and static files : [static](https://github.com/dvaumoron/puzzle/test/blob/main/static) (use [Pico.css](https://picocss.com) and [htmx](https://htmx.org))).

See [this folder](https://github.com/dvaumoron/puzzle/test/tree/main/deploy/conf/helm) for an example of [Helm chart](https://helm.sh) deploying the different services.

See [API Documentation](https://pkg.go.dev/github.com/dvaumoron/puzzle/web) for detailed package descriptions.

## Technical overview

The main server use [Gin](https://gin-gonic.com/) and is backed by microservices called with [gRPC](https://grpc.io/), those services definitions (and list of proposed implementations) are :

1. [puzzlesessionservice](https://github.com/dvaumoron/puzzle/services/session) (this contract is also used for settings storage)
    - [puzzlesessionserver](https://github.com/dvaumoron/puzzle/servers/session)
    - [puzzlesettingsserver](https://github.com/dvaumoron/puzzle/servers/settings)
2. [puzzletemplateservice](https://github.com/dvaumoron/puzzle/services/template)
    - [puzzlegotemplateserver](https://github.com/dvaumoron/puzzle/servers/gotemplate) (use [PartRenderer](https://github.com/dvaumoron/partrenderer))
    - [puzzleindentlangserver](https://github.com/dvaumoron/puzzle/servers/indentlang)
3. [puzzlepassstrengthservice](https://github.com/dvaumoron/puzzle/services/passstrength)
    - [puzzlepassstrengthserver](https://github.com/dvaumoron/puzzle/servers/passstrength)
4. [puzzlesaltservice](https://github.com/dvaumoron/puzzle/services/salt)
    - [puzzlesaltserver](https://github.com/dvaumoron/puzzle/servers/salt)
5. [puzzleloginservice](https://github.com/dvaumoron/puzzle/services/login)
    - [puzzleloginserver](https://github.com/dvaumoron/puzzle/servers/login)
6. [puzzlerightservice](https://github.com/dvaumoron/puzzle/services/right)
    - [puzzlerightserver](https://github.com/dvaumoron/puzzle/servers/right) (use Rego from [Open Policy Agent](https://www.openpolicyagent.org/))
    - [puzzlecachedrightserver](https://github.com/dvaumoron/puzzle/servers/cachedright)
7. [puzzleprofileservice](https://github.com/dvaumoron/puzzle/services/profile)
    - [puzzleprofileserver](https://github.com/dvaumoron/puzzle/servers/profile)

And optionnally (with some kind of page added) :

1. [puzzleforumservice](https://github.com/dvaumoron/puzzle/services/forum)
    - [puzzleforumserver](https://github.com/dvaumoron/puzzle/servers/forum)
2. [puzzlemarkdownservice](https://github.com/dvaumoron/puzzle/services/markdown)
    - [puzzlemarkdownserver](https://github.com/dvaumoron/puzzle/servers/markdown)
3. [puzzleblogservice](https://github.com/dvaumoron/puzzle/services/blog)
    - [puzzleblogserver](https://github.com/dvaumoron/puzzle/servers/blog)
4. [puzzlewikiservice](https://github.com/dvaumoron/puzzle/services/wiki)
    - [puzzlewikiserver](https://github.com/dvaumoron/puzzle/servers/wiki)
5. [puzzlewidgetservice](https://github.com/dvaumoron/puzzle/services/widget), which is a way to add your custom dynamic page in a decoupled way
    - [puzzlegalleryserver](https://github.com/dvaumoron/puzzle/servers/gallery) : Image gallery

List of side projects:

- [puzzlefront](https://github.com/dvaumoron/puzzle/helpers/front) : [WebAssembly](https://webassembly.org/) project containing the majority of browser side interaction.
- [puzzletools](https://github.com/dvaumoron/puzzle/helpers/tools) : [Cobra](https://cobra.dev/) based utility CLI.

List of helper projects :

- [puzzlegrpcserver](https://github.com/dvaumoron/puzzle/servers/grpc)
- [puzzlegrpcclient](https://github.com/dvaumoron/puzzle/clients/grpc)
- [puzzledbclient](https://github.com/dvaumoron/puzzle/clients/db) (use [gorm](https://gorm.io/))
- [puzzlemongoclient](https://github.com/dvaumoron/puzzle/clients/mongo)
- [puzzleredisclient](https://github.com/dvaumoron/puzzle/clients/redis)
- [puzzletelemetry](https://github.com/dvaumoron/puzzle/helpers/telemetry) (use [OpenTelemetry](https://opentelemetry.io/) and [Zap](https://pkg.go.dev/go.uber.org/zap))
- [puzzlesaltclient](https://github.com/dvaumoron/puzzle/clients/salt) (use [x/crypto](https://pkg.go.dev/golang.org/x/crypto))
- [puzzlewidgetserver](https://github.com/dvaumoron/puzzle/servers/widget)
- [puzzlelocaleloader](https://github.com/dvaumoron/puzzle/helpers/localeloader)
- [puzzlemarkdownextension](https://github.com/dvaumoron/puzzle/helpers/markdownextension)
