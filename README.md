# RasaNLG

This allows you to serve NLG (Natural Language Generation) requests for the [Rasa Chatbot](https://rasa.com) in Elixir

Unlike the Rasa Action Server there isn't an OpenAPI spec for this interface.

This code was heavily based on work by the OpenAPI generator and David White, the author of the [rasa-sdk-elixir](https://github.com/whitedr/rasa-sdk-elixir) project.

I used code from that project to bootstrap this project. I included the apache license from that project in this one.

If you want to see this in action you can checkout the  [elixir-rasa-action-server](https://github.com/r26D/elixir-rasa-action-server)
which demonstrates how to use both libraries to serve up the HelpdeskAssistant example from Rasa.


### Building

To install the required dependencies and to build the elixir project, run:
```
mix local.hex --force
mix do deps.get, compile
```

## Installation

The package can be installed
by adding `rasa_nlg` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [ {:rasa_nlg, git: "https://github.com/r26D/rasa-nlg-elixir.git"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/rasa_nlg](https://hexdocs.pm/rasa_nlg).
